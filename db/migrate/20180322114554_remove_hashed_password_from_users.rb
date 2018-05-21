class RemoveHashedPasswordFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :hashed_password, :string, limit: 65
    remove_column :users, :salt, :string, limit: 25
  end
end
