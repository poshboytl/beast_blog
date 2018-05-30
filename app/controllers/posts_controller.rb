class PostsController < ApplicationController
  before_action :author_required, except: [:show, :index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.any(:html, :js) { @posts = posts.page(params[:page]).per(6) }
      format.atom { @posts = Post.published }
    end
  end

  def show
    redirect_to not_found if @post.nil?
    @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(30)
  end

  def new
    @post = current_user.posts.build
    # @post = current_user.posts.create!
    # redirect_to edit_post_path(@post)
  end

  def edit
    @turbolinks_no_cache = true
    # render layout: 'empty'
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  # render json for ajax
  # POST /posts/preview
  def preview
    render json: {
      preview: Post.md2html(params[:content])
    }
  end

  def update
    @post.update(post_params)

    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.json { render json: @post }
    end
  end

  def destroy
    @post.destroy
    redirect_to :posts
  end

  private
    def set_post
      # find by id first, slug may cover id (such as slug = 1)
      @post = Post.find_by_id(params[:id]) || Post.find_by_slug(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :slug, :tag_string, :published, :cover)
    end

    def posts
      posts = Post.order("id DESC")
      # posts = posts.tag_with(params[:tag]) if params[:tag].present?
      posts = posts.tags_with(params[:tags]) if params[:tags].present?
      if params[:author].present?
        posts = posts.joins(:author).where("users.email": params[:author])
        @author = Author.find_by email: params[:author]
      end
      if current_user&.author?
        posts = posts.published.or(posts.draft.where(author_id: current_user.id))
      else
        posts = posts.published
      end
      posts
    end
end
