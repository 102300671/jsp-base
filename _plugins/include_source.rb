require 'cgi'

module Jekyll
  class IncludeSourceTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
      @path = markup.strip
    end

    def render(context)
      site = context.registers[:site]
      full = File.join(site.source, @path)
      return "<!-- not found: #{@path} -->" unless File.exist?(full)
      lang    = File.extname(@path).sub('.', '')
      escaped = CGI.escapeHTML(File.read(full))
      %(<pre><code class="language-#{lang}">#{escaped}</code></pre>)
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
        rel     = f.sub(site.source + '/', '')
        lang    = File.extname(f).sub('.', '')
        escaped = CGI.escapeHTML(File.read(f))
        "### #{rel}\n\n<pre><code class=\"language-#{lang}\">#{escaped}</code></pre>\n\n"
      end.join
    end
  end
end

Liquid::Template.register_tag('include_source', Jekyll::IncludeSourceTag)
Liquid::Template.register_tag('include_tree',   Jekyll::IncludeTreeTag)
