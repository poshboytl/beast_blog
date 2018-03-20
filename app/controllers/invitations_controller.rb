class InvitationsController < ApplicationController
  before_action :load_invitation

  def edit
    invitation
  end

  def update
    invitation.attributes = invitations_params
    if invitation.ready? && invitation.save
      log_in(invitation.author) if invitation.active
      redirect_to :posts
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
    params.require(:invitation).permit(:password, :name)
  end

end
