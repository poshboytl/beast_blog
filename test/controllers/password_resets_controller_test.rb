require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    ActionMailer::Base.deliveries.clear
    @author = users :terry
  end

  def logged_in?
    !session[:user_id].nil?
  end

  test "should get new" do
    get new_password_reset_url
    assert_response :success
  end

  test "email invalid" do
    post password_resets_path, params: { author: { email: "" } }
    assert_not flash.empty?
    assert_response :success
  end

  test "email valid" do
    post password_resets_path, params: { author: { email: @author.email } }
    assert_not_equal @author.reset_digest, @author.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "email not match" do
    @author.create_reset_digest
    get edit_password_reset_path(@author.reset_token, email: "")
    assert_redirected_to root_url
  end

  test "reset token not match" do
    @author.create_reset_digest
    get edit_password_reset_path('wrong token', email: @author.email)
    assert_redirected_to root_url
  end

  test "email and reset_token are right" do
    @author.create_reset_digest
    get edit_password_reset_path(@author.reset_token, email: @author.email)
    assert_response :success
  end

  test "password_confirmation not match" do
    @author.create_reset_digest
    patch password_reset_path(@author.reset_token), params: {
      email: @author.email,
      author: {
        password: '123',
        password_confirmation: '321'
      }
    }

    assert !logged_in?
  end

  # test "password and confirmation are empty" do
  #   @author.create_reset_digest
  #   patch password_reset_path(@author.reset_token), params: {
  #     email: @author.email,
  #     author: {
  #       password: " ",
  #       password_confirmation: " "
  #     }
  #   }
  #   assert_not flash.empty?
  # end

  test "password and confirmation are ok" do
    @author.create_reset_digest
    patch password_reset_path(@author.reset_token), params: {
      email: @author.email,
      author: {
        password: '123',
        password_confirmation: '123'
      }
    }

    assert_not flash.empty?
    assert logged_in?
    assert_redirected_to :root
  end

end
