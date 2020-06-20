# frozen_string_literal: true

class TaskMover
  def initialize(task_id, project_id)
    @task_id = task_id
    @project_id = project_id
  end

  def move_up
    @task = Task.find_by(id: @task_id)
    @tasks = Task.where("project_id = ?", @project_id).order(priority: :desc)
    task_index = @tasks.index(@task)
    if @task
      if task_index != 0
        swap_priorities(task_index, task_index - 1)
        1
      else
        2
      end
    else
      3
    end
  end

  def move_down
    @task = Task.find_by(id: @task_id)
    @tasks = Task.where("project_id = ?", @project_id).order(priority: :desc)
    task_index = @tasks.index(@task)
    if @task
      if task_index != @tasks.length - 1
        swap_priorities(task_index, task_index + 1)
        1
      else
        2
      end
    else
      3
    end
  end

  private

  def swap_priorities(index1, index2)
    task1 = @tasks[index1]
    task2 = @tasks[index2]
    temp = task1[:priority]
    task1.update(priority: task2[:priority])
    task2.update(priority: temp)
  end
end
