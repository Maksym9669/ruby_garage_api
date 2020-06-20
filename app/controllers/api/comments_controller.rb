# frozen_string_literal: true

module Api
  class CommentsController < ApplicationController
    before_action :authenticate_user!

    def index
      @comments = Comment.where("task_id = ?", params[:task_id])
      authorize @comments if @comments.present?
      render json: { data: @comments }
    end

    def new
      @comment = Comment.new
    end

    def show
      @comment = Comment.find_by(id: params[:id])
      if @comment
        authorize @comment
        render json: { data: @comment }
      else
        render json: { "error": I18n.t("Comment not found") }, status: 404
      end
    end

    def create
      @comment = Comment.new(comment_params)
      if @comment.save
        render json: { data: @comment }, status: 201
      else
        render json: { "error": @comment.errors }, status: 400
      end
    end

    def destroy
      @comment = Comment.find_by(id: params[:id])
      if @comment
        authorize @comment
        if @comment.destroy
          render json: { success: { text: I18n.t("Comment was successfully deleted") }}, status: 200
        else
          render json: { "error": @comment.errors }, status: 400
        end
      else
        render json: { "error": I18n.t("Comment not found") }, status: 404
      end
    end

    private

    def comment_params
      params.permit(:content, :task_id, :attachment)
    end
  end
end
