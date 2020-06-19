module Api
    class PriorityUpController < ApplicationController
        before_action :authenticate_user!

         def update
            @task = Task.find_by(id: params[:id])
            authorize @task
            @tasks = Task.where("project_id = ?", params[:project_id]).order(priority: :desc)
            taskIndex = @tasks.index(@task)
            if @task
                if taskIndex != 0
                    move_up(taskIndex)
                    render json: { success: { text: "Task was moved up" } }, status: 200
                else
                    render json: { "error": "This task can't be moved up" }, status: 400
                end
            else
              render json: { "error": "Task not found" }, status: 404
            end
         end
      
        private
      
        def task_params
         params.permit(:status)
        end

        def move_up(index)
            task = @tasks[index-1]
            temp = @task[:priority]
            @task.update(priority: task[:priority])
            task.update(priority: temp)
        end
    end
end