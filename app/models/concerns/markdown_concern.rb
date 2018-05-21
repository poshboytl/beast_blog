require 'rouge/plugins/redcarpet'

module MarkdownConcern
  extend ActiveSupport::Concern

  module ClassMethods
    class HTML < Redcarpet::Render::HTML
      include Rouge::Plugins::Redcarpet
    end

    def md2html(md)
      markdown = Redcarpet::Markdown.new(HTML, autolink: true, tables: true, fenced_code_blocks: true)
      markdown.render(md)
    end
  end

end
