# frozen_string_literal: true

module Api
  class PriorityUpController < ApplicationController
    before_action :authenticate_user!

    def update
      authorize task
      result = task_mover.move_up
      case result
      when Constants::TASK_MOVED
        render json: { success: { text: I18n.t("Task was moved up") } }, status: 200
      when Constants::TASK_CANT_MOVE
        render json: { "error": I18n.t("This task can't be moved up") }, status: 400
      when Constants::TASK_NOT_FOUND
        render json: { "error": I18n.t("Task not found") }, status: 404
      end
    end

    private

    def task
        @task ||= Task.find_by(id: params[:id])
    end

    def task_mover
        @task_mover = TaskMover.new(params[:id], params[:project_id])
    end
  end
end
