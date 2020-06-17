# frozen_string_literal: true

module Api
  class ProjectsController < ApplicationController
    before_action :authenticate_user!

    def index
      @projects = Project.all
      authorize @projects
      render json: {data: @projects, user: current_user}
    end
  end
end
