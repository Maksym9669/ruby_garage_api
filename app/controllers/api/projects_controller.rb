class Api::ProjectsController < ApplicationController
    def index
     @projects = Project.all
     render json: @projects
    end
end
