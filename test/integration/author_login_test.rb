require 'test_helper'

class AuthorLoginTest < ActionDispatch::IntegrationTest
  attr_reader :author, :password

  def setup
    @password = "111111"
    @author = Author.create(email: "user@example.com", password: password)
  end

  test "click login link" do
    visit "/"

    assert_current_path root_path

    within "#blog-header" do
      click_link I18n.t("layouts.header.login")
    end
    assert_current_path login_path
  end

  test "click mobile login link" do
    visit "/"
    assert_current_path root_path
    within "#menu" do
      click_link I18n.t("layouts.header.login")
    end
    assert_current_path login_path
  end

  test "login action success" do
    visit login_path

    within ".login-page form" do
      email_field = find(:css, "input[name='session[email]']")
      password_field = find(:css, "input[name='session[password]']")
      fill_in email_field[:name], with: author.email
      fill_in password_field[:name], with: password
      click_button I18n.t("sessions.form.submit")
      assert_current_path posts_path
    end
  end

  test "login action failed" do
    visit login_path

    within ".login-page form" do
      email_field = find(:css, "input[name='session[email]']")
      password_field = find(:css, "input[name='session[password]']")
      fill_in email_field[:name], with: "user@example.com"
      fill_in password_field[:name], with: "123456"
      click_button I18n.t("sessions.form.submit")
      assert_current_path sessions_path
    end

    assert_content I18n.t("activemodel.errors.models.session.not_matched")
  end
end
