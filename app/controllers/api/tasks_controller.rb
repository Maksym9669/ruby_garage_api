# frozen_string_literal: true

module Api
  class TasksController < ApplicationController
    before_action :authenticate_user!

    def index
      @tasks = Task.where("project_id = ?", params[:project_id]).order(priority: :desc)
      authorize @tasks if @tasks.present?
      render json: { data: @tasks }
    end

    def new
      @task = Task.new
    end

    def show
      @task = Task.find_by(id: params[:id])
      if @task
        authorize @task
        render json: { data: @task }
      else
        render json: { "error": I18n.t("Task not found") }, status: 404
      end
    end

    def create
      @task = Task.new(task_params)
      if @task.save
        render json: { data: @task }, status: 201
      else
        render json: { "error": @task.errors }, status: 400
      end
    end

    # Set deadline in update action
    def update
      @task = Task.find_by(id: params[:id])
      if @task
        authorize @task
        if @task.update_attributes(task_params)
          render json: { data: @task }, status: 200
        else
          render json: { "error": @task.errors }, status: 400
        end
      else
        render json: { "error": I18n.t("Task not found") }, status: 404
      end
    end

    def destroy
      @task = Task.find_by(id: params[:id])
      if @task
        authorize @task
        if @task.destroy
          render json: { success: { text: I18n.t("Task was successfully deleted") } }, status: 200
        else
          render json: { "error": @task.errors }, status: 400
        end
      else
        render json: { "error": I18n.t("Task not found") }, status: 404
      end
    end

    private

    def task_params
      params.permit(:name, :project_id, :deadline, :status)
    end
  end
end
