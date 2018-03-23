class AddCookedContentToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :cooked_content, :text
  end
end
