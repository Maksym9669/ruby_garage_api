module Api
    class TasksController < ApplicationController
        
        def index
            @tasks = Task.where("project_id = ?", params[:project_id])
            # authorize @tasks
            render json: { data: @tasks}
        end

        private

        def task_params
          params.permit(:name, :project_id, :deadline, :status)
        end
    end
end