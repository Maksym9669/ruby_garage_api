# frozen_string_literal: true

module Api
  class ProjectsController < ApplicationController
    before_action :authenticate_user!
    def index
      @projects = Project.all
      render json: {data: @projects, stuff: current_user}
    end
  end
end
