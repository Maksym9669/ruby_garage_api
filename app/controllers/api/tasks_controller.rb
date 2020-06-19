module Api
    class TasksController < ApplicationController
        
        def index
            @tasks = Task.where("project_id = ?", params[:project_id])
            authorize @tasks if !@tasks.empty?
            render json: { data: @tasks}
        end

        
        def new
            @task = Task.new
        end

        def create
            @task = Task.new(task_params)
            if @task.save
                render json: { data: @task }, status: 201
            else
                render json: { "error": @task.errors }, status: 400
            end
        end

        private

        def task_params
          params.permit(:name, :project_id, :deadline)
        end
    end
end