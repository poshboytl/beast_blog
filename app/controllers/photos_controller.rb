class PhotosController < ApplicationController
  before_action :author_required

  def new
    @photo = Photo.new
  end

  # upload image
  def create
    @photo = Photo.new(photo_params.merge(author_id: current_user.id))

    if @photo.save
      render json: {
        ok: true,
        url: @photo.image.url
      }
    else
      render json: {
        ok: false
      }
    end

  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end
end
