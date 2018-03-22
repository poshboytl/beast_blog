require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  attr_reader :author, :plain_password

  def setup
    @author = users :terry
    @plain_password = 'imthesuperman'
  end

  class PasswordTest < AuthorTest
    def setup
      super
      @author = Author.new
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
  end

  # .authenticate
  class AuthenticateTest < AuthorTest
    test "it should authenticate the password" do
      assert_equal author, Author.authenticate(author.email, plain_password)
    end
  end

end
