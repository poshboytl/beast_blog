class Post < ApplicationRecord
  mount_uploader :cover, ImageUploader

  include MarkdownConcern
  # the album feature is removed in current version
  # enum category: { article: 0, album: 1 }

  belongs_to :author, optional: true

  has_many :comments
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates_uniqueness_of :slug, conditions: -> { where.not(slug: [nil, '']) }
  validates :title, presence: true
  validate :slug_cant_be_only_integer

  before_save :format_slug, :create_tags, :cook_content

  scope :tag_with, ->(tag_name) { joins(:tags).where("tags.name = ?", tag_name) }
  scope :tags_with, ->(tag_names) { joins(:tags).where("tags.name IN (?)", tag_names) }
  scope :published, -> { where(published: true) }
  scope :draft, -> { where(published: [false, nil]) }

  def add_tags(*tag_names)
    tags.clear
    tag_names.each do |tag_name|
      tags << Tag.find_or_initialize_by(name: tag_name)
    end
  end

  def to_slug
    slug = self.slug
    return slug unless slug.present?

    slug.gsub! /['`]/,""
    slug.gsub! /[.`]/,""
    slug.gsub! /\s*@\s*/, " at "
    slug.gsub! /\s*&\s*/, " and "
    slug.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'
    slug.gsub! /_+/,"-"
    slug.gsub! /\A[_\.]+|[_\.]+\z/,""

    URI.encode slug
  end

  def abstract
    return '' unless self.cooked_content.present?

    # first p tag or first 100 words
    (/<p>([\s\S]*?)<\/p>/.match(self.cooked_content).to_a.last || self.cooked_content.first(100)).gsub(/<img([^>])+>/, "")
  end

  def tag_string=(str)
    @tag_string = str
  end

  def tag_string
    @tag_string ||= tags.map(&:name).join(", ")
  end

  private

  def format_slug
    self.slug = self.to_slug
  end

  def create_tags
    add_tags *tag_string.split(',').map(&:strip)
  end

  def cook_content
    return if self.content.nil?
    self.cooked_content = Post.md2html(self.content)
  end

  def slug_cant_be_only_integer
    errors.add(:slug, I18n.t("activerecord.errors.models.post.attributes.slug.cant_be_only_integer")) if /^\d+$/ =~ to_slug
  end

end
