class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.string :status, null: false, default: "active"
      t.datetime :deadline

      t.timestamps
    end

    add_reference :tasks, :project, index: true, null: false
    add_foreign_key :tasks, :projects
  end
end
