module Api
    class TasksDoneController < ApplicationController
        def update
            @task = Task.find_by(id: params[:id])
            if @task
              authorize @task
              @task.update(status: "done")
              render json: { data: @task }, status: 200
            else
              render json: { "error": "Task not found" }, status: 404
            end
        end

        private

        def task_params
            params.permit(:status)
        end
    end
end