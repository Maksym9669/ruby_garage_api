module Api
    class PriorityUpController < ApplicationController
        before_action :authenticate_user!

         def update
            task_mover = TaskMover.new(params[:id], params[:project_id])
            task =  Task.find_by(id: params[:id])
            authorize task
            result = task_mover.move_up
            case result
            when 1
                render json: { success: { text: "Task was moved up" } }, status: 200
            when 2
                render json: { "error": "This task can't be moved up" }, status: 400
            when 3
                render json: { "error": "Task not found" }, status: 404
            end
         end
    end
end