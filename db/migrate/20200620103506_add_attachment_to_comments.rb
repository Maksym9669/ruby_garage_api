class AddAttachmentToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :attachment, :string
  end
end
