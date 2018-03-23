class Photo < ApplicationRecord
  belongs_to :author

  mount_uploader :image, ImageUploader
end
