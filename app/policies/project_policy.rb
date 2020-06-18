# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def index?
    true
  end

  def update?
    authorize_project
  end

  def destroy?
    authorize_project
  end

  def show?
    authorize_project
  end

  private

  def authorize_project
    user[:id] == record[:user_id]
  end
end
