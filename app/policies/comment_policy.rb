# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
    def index?
      true
    end
  
    def destroy?
      authorize_comment
    end
  
    def show?
      authorize_comment
    end
  
    private
  
    def authorize_comment
    #   user[:id] == record[:user_id]
        true
    end
  end
  