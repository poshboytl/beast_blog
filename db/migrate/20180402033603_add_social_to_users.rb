class AddSocialToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :twitter, :string
    add_column :users, :weibo, :string
    add_column :users, :github, :string
  end
end
