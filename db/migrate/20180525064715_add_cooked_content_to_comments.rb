class AddCookedContentToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :cooked_content, :text
  end
end
