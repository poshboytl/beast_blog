require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @params = {
      invitation: {
        email: 'terry@example.com',
        name: 'terry'
      }
    }
  end

  test "Create invitation" do
    sign_in_as users(:terry_admin)
    assert_difference 'Invitation.count', 1 do
      post invitations_path(params: @params), xhr: true
      assert_response :success
    end
  end

  test "Not admin" do
    post invitations_path(params: @params)
    assert_redirected_to new_session_path
  end

end
