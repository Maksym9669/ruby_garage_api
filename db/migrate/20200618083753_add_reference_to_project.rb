class AddReferenceToProject < ActiveRecord::Migration[6.0]
  def change
    add_reference :projects, :user, index: true
    add_foreign_key :projects, :users
  end
end
