# frozen_string_literal: true

module Api
  class ProjectsController < ApplicationController
    before_action :authenticate_user!

    def index
      @projects = Project.where("user_id = ?", current_user[:id])
      authorize @projects unless @projects.empty?
      render json: { data: @projects, user: current_user }
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params)
      @project[:user_id] = current_user[:id]
      if @project.save
        render json: { data: @project }, status: 201
      else
        render json: { "error": @project.errors }, status: 400
      end
    end

    def show
      @project = Project.find_by(id: params[:id])
      @tasks = Task.where("project_id=?", params[:id]).order(priority: :desc)
      if @project
        authorize @project
        render json: { data: { project: @project, tasks: @tasks } }
      else
        render json: { "error": I18n.t("Project not found") }, status: 404
      end
    end

    def update
      @project = Project.find_by(id: params[:id])
      if @project
        authorize @project
        if @project.update_attributes(project_params)
          render json: { data: @project }, status: 200
        else
          render json: { "error": @project.errors }, status: 400
        end
      else
        render json: { "error": I18n.t("Project not found") }, status: 404
      end
    end

    def destroy
      @project = Project.find_by(id: params[:id])
      if @project
        authorize @project
        if @project.destroy
          render json: { success: { text: I18n.t("Project was successfully deleted") } }, status: 200
        else
          render json: { "error": @project.errors }, status: 400
        end
      else
        render json: { "error": I18n.t("Project not found") }, status: 404
      end
    end

    private

    def project_params
      params.permit(:name)
    end
  end
end
