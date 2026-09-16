require 'cgi'
require 'rouge'

module Jekyll
  # 源码嵌入：Rouge 语法高亮 + 移动端自动换行
  module SourceCode
    # 移动端自动换行：pre-wrap 保留缩进并按需换行，word-break 防止长行溢出
    WRAP_STYLE = 'white-space: pre-wrap; word-break: break-word; overflow-wrap: anywhere;'.freeze

    def self.render(content, lang)
      lexer = Rouge::Lexer.find_fancy(lang) || Rouge::Lexers::PlainText
      formatter = Rouge::Formatters::HTML.new(css_class: 'highlight')
      highlighted = formatter.format(lexer.lex(content))
      %(<div class="language-#{CGI.escapeHTML(lang)} highlighter-rouge"><pre class="highlight" style="#{WRAP_STYLE}">#{highlighted}</pre></div>)
    end
  end

  class IncludeSourceTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
      @path = markup.strip
    end

    def render(context)
      site = context.registers[:site]
      full = File.join(site.source, @path)
      return "<!-- not found: #{@path} -->" unless File.exist?(full)
      lang = File.extname(@path).sub('.', '')
      SourceCode.render(File.read(full), lang)
    end
  end

  class IncludeTreeTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
      parts = markup.strip.split(/\s+/, 2)
      @path = parts[0]
      @exts = parts[1] ? parts[1].split(',').map(&:strip) : nil
    end

    def render(context)
      site = context.registers[:site]
      root = File.join(site.source, @path)
      return "<!-- not found: #{@path} -->" unless File.exist?(root)

      files = Dir.glob(File.join(root, '**', '*')).select { |f| File.file?(f) }
      files.select! { |f| @exts.include?(File.extname(f).sub('.', '')) } if @exts
      files.sort!

      files.map do |f|
        rel  = f.sub(site.source + '/', '')
        lang = File.extname(f).sub('.', '')
        "### #{rel}\n\n#{SourceCode.render(File.read(f), lang)}\n\n"
      end.join
    end
  end
end

Liquid::Template.register_tag('include_source', Jekyll::IncludeSourceTag)
Liquid::Template.register_tag('include_tree',   Jekyll::IncludeTreeTag)
