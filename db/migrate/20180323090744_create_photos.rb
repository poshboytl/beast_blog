class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.string :image
      t.references :author, index: true

      t.timestamps
    end
  end
end
