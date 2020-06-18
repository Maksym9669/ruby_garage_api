# frozen_string_literal: true

class TaskPolicy < ApplicationPolicy
    def index?
      true
    end
  
    def update?
      authorize_task
    end
  
    def destroy?
      authorize_task
    end
  
    def show?
      authorize_task
    end
  
    private
  
    def authorize_task
      user[:id] == record[:user_id]
    end
end
  