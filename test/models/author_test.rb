require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  attr_reader :author, :plain_password

  def setup
    @author = users :terry
    @plain_password = 'imthesuperman'
  end

  class EmailTest < AuthorTest
    def setup
      super
      @author = Author.new(password: "111111")
    end

    test "valid email" do
      author.email = "terry@example.com"
      assert author.valid?
    end

    test "invalid email" do
      author.email = "user"
      assert_not author.valid?
    end

    test "email should presence" do
      author.email = ""
      assert_not author.valid?
    end

    test "email should be unique" do
      Author.create!(email: "terry@example.com", password: '123456')
      author.email = "terry@example.com"
      assert_not author.valid?
    end
  end

  class PasswordTest < AuthorTest
    def setup
      super
      @author = Author.new(email: 'user@example.com')
    end

    # #password=
    test "user's password_digest should be set" do
      author.password = plain_password
      assert BCrypt::Password.new(author.password_digest).is_password?(plain_password)
    end

    # #password
    test "it should return the plaintext password" do
      author.password = plain_password
      assert_equal 'imthesuperman', author.password
    end

    test "password size less than 6" do
      author.password = '12345'
      assert_not author.valid?
    end
  end

  # .authenticate
  class AuthenticateTest < AuthorTest
    test "it should authenticate the password" do
      assert_equal author, Author.authenticate(author.email, plain_password)
    end
  end

end
