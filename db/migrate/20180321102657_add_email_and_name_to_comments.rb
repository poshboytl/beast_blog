class AddEmailAndNameToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :email, :string
    add_column :comments, :name, :string
  end
end
