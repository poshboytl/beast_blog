class AuthorsController < ApplicationController
  before_action :author_required, only: [:edit, :update]

  def index
    @authors = Author.includes(:posts).page(params[:page]).per(5)
  end

  def edit
    @author = current_user
  end

  def update
    @author = current_user
    if @author.update(author_params)
      redirect_to :posts, flash: { success: t('.update_success') }
    else
      render :edit
    end
  end

  private

  def author_params
    params.require(:author).permit(:name, :bio, :avatar, :twitter, :weibo, :github)
  end
end
