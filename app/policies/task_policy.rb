# frozen_string_literal: true

class TaskPolicy < ApplicationPolicy
  def index?
    # user[:id] == Project.find_by(id: record.first[:project_id])[:user_id]
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
    user[:id] == Project.find_by(id: record[:project_id])[:user_id]
  end
end
