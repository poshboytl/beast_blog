require 'test_helper'

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :terry
    sign_in_as @user
  end

  test "should edit success" do
    get edit_author_path(@user)
    assert_response :success
  end

  test "update user info" do
    params = {
      author: {
        name: 'terry',
        bio: 'hhh'
      }
    }

    patch author_path(@user), params: params

    @user.reload

    assert_response :redirect
    params[:author].each do |key, value|
      assert_equal value, @user.public_send(key)
    end
  end
end
