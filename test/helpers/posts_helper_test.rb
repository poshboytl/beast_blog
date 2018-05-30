require 'test_helper'

class PostsHelperTest < ActionView::TestCase
  attr_reader :post

  def setup
    @post = posts :article
  end

  test "sort tags" do
    tag_string = (1..10).map { |n| "tag#{n}" }.join(", ")
    post.update!(tag_string: tag_string)

    # tag1 and tag7 are selected
    names = %w(tag1 tag7)
    sorted_tags = sort_tags(names)
    expected_tag_names = %w(tag1 tag7 tag2 tag3 tag4 tag5 tag6 tag8 tag9 tag10)
    assert_equal expected_tag_names, sorted_tags.map(&:name)
  end
end
