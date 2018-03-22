class InvitationsController < ApplicationController
  before_action :admin_required, only: [:new, :create]
  before_action :load_invitation, only: [:edit, :update]

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(create_invitation_params)
    if @invitation.save
      redirect_to :posts, flash: { notice: t('.invite_success') }
    else
      render :new
    end
  end

  def edit
    invitation
  end

  def update
    invitation.attributes = invitations_params
    if invitation.ready? && invitation.save
      log_in(invitation.author) if invitation.active
      redirect_to :posts
    else
      render 'edit'
    end
  end

  private

  def load_invitation
    redirect_to root_path unless invitation&.available?
  end

  def invitation
    @invitation ||= Invitation.find_by_code(params[:id])
  end

  def invitations_params
    params.require(:invitation).permit(:password, :name, :password_confirmation)
  end

  def create_invitation_params
    params.require(:invitation).permit(:email, :name)
  end

end
