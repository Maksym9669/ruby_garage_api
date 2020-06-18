# frozen_string_literal: true

module Api
  class ProjectsController < ApplicationController
    before_action :authenticate_user!

    def index
      @projects = Project.where("user_id = ?", current_user[:id])
      authorize @projects
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
        render json: {"error": @project.errors}, status: 400
      end
    end

    def show 
      @project = Project.find_by(id: params[:id])
      if @project
        authorize @project
        render json: { data: @project }
      else
        render json: { "error": "Project not found"}, status: 404
      end
    end

    def update
      @project = Project.find_by(id: params[:id])
      authorize @project
      if @project.update_attributes(project_params)
        render json: { data: @project}, status: 200
      else
        render json: {"error": @project.errors}, status: 400
      end
    end

    def destroy
      @project = Project.find_by(id: params[:id])
      authorize @project
      if @project.destroy
        render json: { success: { text: "Project was successfully deleted"}}, status: 200
      else
        render json: {"error": @project.errors}, status: 400
      end
    end

    private

    def project_params
      params.require(:project).permit(:name)
    end

  end
end
