class ArchivesController < ApplicationController

  def show
    @posts = Post.order(id: :desc).published.group_by { |post| post.created_at.beginning_of_month }
  end

end
