class PasswordResetsController < ApplicationController
  before_action :get_author,   only: [:edit, :update]
  before_action :valid_author, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
    @author = current_user
  end

  def create
    @author = current_user || Author.find_by(email: params[:author][:email].downcase)
    if @author
      @author.create_reset_digest_and_send_email
      redirect_to :root, flash: { info: t('.reset_email_send') }
    else
      flash.now[:danger] = t('.email_not_found')
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:author][:password].empty?
      @author.errors.add(:password, t('.password_not_empty'))
      render 'edit'
    elsif @author.update(author_params)
      log_in @author
      flash[:success] = t('.success')
      redirect_to :root
    else
      render 'edit'
    end
  end

  private

  def get_author
    @author = Author.find_by(email: params[:email])
  end

  def author_params
    params.require(:author).permit(:password, :password_confirmation)
  end

  def valid_author
    unless @author&.reset_authenticated?(params[:id])
      redirect_to root_url
    end
  end

  # 检查重设令牌是否过期
  def check_expiration
    if @author.password_reset_expired?
      flash[:danger] = t("password_resets.check_expiration.reset_expired")
      redirect_to root_url
    end
  end
end
