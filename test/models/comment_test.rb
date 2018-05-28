require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @post = posts :article
    @author = @post.author
    @common_email = "terry@example.com"
    @content = "sofa"
  end

  test "common comment" do
    comment = @post.comments.create!(
      email: @common_email,
      content: @content
    )
    assert_equal ActionMailer::DeliveryJob, comment.send(:notify_author).class
    assert_nil comment.send(:notify_parent)
  end

  test "comment by author" do
    comment = @post.comments.create!(
      content: @content,
      user: @author
    )
    assert_nil comment.send(:notify_author)
    assert_nil comment.send(:notify_parent)
  end

  test "comment with parent" do
    parent_comment = @post.comments.create!(
      email: "111@example.com",
      content: @content
    )
    comment = @post.comments.create!(
      email: @common_email,
      content: @content,
      parent: parent_comment
    )
    assert_equal ActionMailer::DeliveryJob, comment.send(:notify_author).class
    assert_equal ActionMailer::DeliveryJob, comment.send(:notify_parent).class
  end

  test "parent is himself" do
    parent_comment = @post.comments.create!(
      email: @common_email,
      content: @content
    )
    comment = @post.comments.create!(
      email: @common_email,
      content: @content,
      parent: parent_comment
    )
    assert_equal ActionMailer::DeliveryJob, comment.send(:notify_author).class
    assert_nil comment.send(:notify_parent)
  end

  test "reply author's comment" do
    parent_comment = @post.comments.create!(
      user: @author,
      content: @content
    )
    comment = @post.comments.create!(
      email: @common_email,
      content: @content,
      parent: parent_comment
    )
    assert_equal ActionMailer::DeliveryJob, comment.send(:notify_parent).class
    assert_nil comment.send(:notify_author)
  end

  test "cook content before save" do
    content = "a \r\n b \r\n c \r\n"
    expected_cooked_content = "a <br/> b <br/> c <br/>"
    comment = @post.comments.create!(
      user: @author,
      content: content
    )
    assert_equal expected_cooked_content, comment.cooked_content
  end

end
