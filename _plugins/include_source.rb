# frozen_string_literal: true
require "rouge"
require "cgi"
require "uri"

module Jekyll
  # 从磁盘读取源文件，渲染为「源码 + 预览」双 tab 组件。
  # 与 `_includes/` 不同，被包含文件保留在原始位置，file:// 可直接打开。
  # 用法：
  #   {% include_source jsp-src/src/main/webapp/lab1/info/index.jsp %}
  #       JSP 等动态页面不在站内输出，预览指向站外服务器（见 _config.yml 的 include_source）：
  #       jsp-src/src/main/webapp/xxx.jsp → http://localhost:8080/jsp-base/xxx.jsp
  #   {% include_source some.jsp base=http://host:port/ctx %}  标签内临时覆盖预览根地址
  #   {% include_source labs/lab1/work1/ dir %}                        遍历目录，包含其下全部文件
  #   {% include_source labs/lab1/work1/ dir ext=html,css,js %}         仅包含指定后缀（逗号分隔，. 可省略）
  #   {% include_source labs/lab1/work1/ dir recursive ext=html %}      递归遍历子目录
  #   目录模式下 preview / nopreview 对其中每个文件分别生效
  class IncludeSourceTag < Liquid::Tag
    PREVIEW_EXTS  = %w[.html .htm .xhtml .jsp .jspx].freeze
    FRONT_MATTER  = /\A---\s*\r?\n.*?\r?\n---\s*\r?\n/m
    ASSETS_FLAG   = "_include_source_assets"
    ERR_PREFIX    = "include_source: "

    ASSETS = <<~HTML
      <style>
        .isrc { margin: 1rem 0 1.2rem; }
        .isrc-tabs { display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.5rem; }
        .isrc-tab {
          padding: 0.15rem 0.9rem;
          font-size: 0.85rem;
          line-height: 1.4;
          border-radius: 999px;
          border: 1px solid var(--language-border-color, #dee2e6);
          background: transparent;
          color: var(--code-header-text-color, inherit);
          cursor: pointer;
        }
        .isrc-tab:hover { border-color: var(--bs-primary, #3674b9); }
        .isrc-tab.isrc-active {
          background: var(--bs-primary, #3674b9);
          border-color: transparent;
          color: #fff;
        }
        .isrc-open {
          margin-left: auto;
          font-size: 0.8rem;
          text-decoration: none;
          color: var(--code-header-text-color, inherit);
          opacity: 0.75;
        }
        .isrc-open:hover { opacity: 1; text-decoration: underline; }
        .isrc-code .highlighter-rouge { margin-top: 0; margin-bottom: 0; }
        .isrc-preview {
          display: block;
          height: 480px;
          resize: vertical;
          overflow: hidden;
          background: #fff;
          border-radius: var(--bs-border-radius-lg, 0.75rem);
          box-shadow: var(--language-border-color, #dee2e6) 0 0 0 1px;
        }
        .isrc-preview iframe { display: block; width: 100%; height: 100%; border: 0; }
      </style>
      <script>
        (function () {
          if (window.__isrc_bound) return;   /* 幂等：重复注入不重复绑定 */
          window.__isrc_bound = true;

          function setOpenLink(f, url) {
            var box = f.closest('.isrc');
            if (!box) return;
            var link = box.querySelector('.isrc-open');
            if (link) link.setAttribute('href', url);
          }

          /* 云端优先、本地回退：探测云端可达性，3s 超时则用 fallback */
          function resolveSrc(f) {
            var resolved = f.getAttribute('data-resolved');
            if (resolved) { f.src = resolved; setOpenLink(f, resolved); return; }
            var cloud = f.getAttribute('data-src');
            var local = f.getAttribute('data-fallback');
            if (!local || !cloud) { f.src = cloud || local || ''; return; }

            var done = false;
            var ctrl = (typeof AbortController !== 'undefined') ? new AbortController() : null;
            var timer = setTimeout(function () {
              if (done) return; done = true;
              if (ctrl) try { ctrl.abort(); } catch (e) {}
              f.setAttribute('data-resolved', local);
              f.src = local; setOpenLink(f, local);
            }, 3000);

            fetch(cloud, { mode: 'no-cors', cache: 'no-store',
                           signal: ctrl ? ctrl.signal : undefined })
              .then(function () {
                if (done) return; done = true; clearTimeout(timer);
                f.setAttribute('data-resolved', cloud);
                f.src = cloud; setOpenLink(f, cloud);
              })
              .catch(function () {
                if (done) return; done = true; clearTimeout(timer);
                f.setAttribute('data-resolved', local);
                f.src = local; setOpenLink(f, local);
              });
          }

          document.addEventListener('click', function (e) {
            var btn = e.target.closest && e.target.closest('.isrc-tab');
            if (!btn) return;
            var box = btn.closest('.isrc');
            if (!box) return;
            var view = btn.getAttribute('data-view');
            var previewPane = box.querySelector('.isrc-preview');

            /* 离开预览时把 iframe 重置回初始页 */
            if (view === 'code' && previewPane && !previewPane.hidden) {
              box.querySelectorAll('.isrc-preview iframe').forEach(function (f) {
                var r = f.getAttribute('data-resolved');
                if (r) f.src = r;
              });
            }

            box.querySelectorAll('.isrc-tab').forEach(function (t) {
              var on = t === btn;
              t.classList.toggle('isrc-active', on);
              t.setAttribute('aria-selected', on ? 'true' : 'false');
            });
            box.querySelectorAll('.isrc-pane').forEach(function (p) {
              p.hidden = !p.classList.contains('isrc-' + view);
            });

            /* 切到预览时触发探测/加载 */
            if (view === 'preview') {
              var f = box.querySelector('.isrc-preview iframe');
              if (f && !f.getAttribute('data-resolved')) resolveSrc(f);
            }
          });

          /* 初始默认显示预览的组件立即探测 */
          function initShown() {
            document.querySelectorAll('.isrc-preview:not([hidden]) iframe')
              .forEach(function (f) {
                if (!f.getAttribute('data-resolved')) resolveSrc(f);
              });
          }
          if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', initShown);
          } else {
            initShown();
          }
        })();
      </script>
    HTML

    def initialize(tag_name, markup, tokens)
      super
      args  = markup.strip.split(/\s+/)
      @path = args.shift.to_s
      @opts = args.each_with_object({}) do |opt, h|
        k, v = opt.split("=", 2)
        h[k] = v || true
      end
    end

    def render(context)
      return err("missing path") if @path.empty?

      site = context.registers[:site]
      full = resolve(site)
      return err("not found: #{@path}") unless full

      if File.directory?(full)
        return err("is a directory: #{@path} (add 'dir' to traverse it)") unless directory_mode?
        render_directory(context, site, full)
      else
        render_file(context, site, full)
      end
    end

    def render_file(context, site, full, display_name: nil)
      stack = (Thread.current[:isrc_stack] ||= [])
      return err("circular: #{display_name || @path}") if stack.include?(full)

      stack.push(full)
      begin
        raw  = read_cached(site, full)
        code = render_code(strip_front_matter(raw), full, display_name)
        return code unless previewable?(site, full)
        render_preview(context, site, code, full)
      rescue StandardError => e
        err("#{e.class}: #{e.message}")
      ensure
        stack.pop
      end
    end

    private

    # ---------- 路径 ----------

    def resolve(site)
      full = File.expand_path(@path, site.source)
      return nil unless full.start_with?(site.source)
      return nil unless File.file?(full) || File.directory?(full)
      full
    end

    # ---------- 目录遍历 ----------

    def directory_mode?
      @opts.key?("dir")
    end

    def render_directory(context, site, dir)
      files = collect_files(dir)
      return err("no matching files in: #{@path}") if files.empty?

      files.map do |f|
        rel = f.sub(/\A#{Regexp.escape(dir)}\/?/, "")
        render_file(context, site, f, display_name: rel)
      end.join("\n")
    end

    # 按相对路径排序，保证多次构建输出稳定；隐藏文件/目录（. 开头）始终排除
    def collect_files(dir)
      paths = if @opts.key?("recursive")
        Dir.glob(File.join(dir, "**", "*"))
      else
        Dir.children(dir).map { |name| File.join(dir, name) }
      end

      exts = allowed_extensions
      paths.select do |f|
        rel = f.sub(/\A#{Regexp.escape(dir)}\/?/, "")
        next false unless File.file?(f)
        next false if rel.split(File::SEPARATOR).any? { |seg| seg.start_with?(".") }
        next false if exts && !exts.include?(File.extname(f).downcase)
        true
      end.sort_by { |f| f.delete_prefix(dir) }
    end

    # ext=html,css,.js → [".html", ".css", ".js"]；缺省或为空表示不过滤
    def allowed_extensions
      raw = @opts["ext"]
      return nil if raw.nil? || raw.to_s.strip.empty?
      raw.to_s.split(",").map { |s| ".#{s.strip.delete_prefix(".").downcase}" }
         .reject { |ext| ext == "." }.uniq
    end

    # ---------- 读取（mtime + size 缓存）----------

    def read_cached(site, path)
      stat = File.stat(path)
      sig  = [stat.mtime.to_f, stat.size]

      cache = site.instance_variable_get(:@isrc_files) ||
              site.instance_variable_set(:@isrc_files, {})
      entry = cache[path]
      return entry[:content] if entry && entry[:sig] == sig

      content = File.read(path, encoding: "UTF-8")
      cache[path] = { sig: sig, content: content }
      content
    end

    def strip_front_matter(content)
      content.sub(FRONT_MATTER, "").rstrip
    end

    # ---------- 高亮 ----------

    def render_code(content, path, display_name = nil)
      ext   = File.extname(path).downcase
      lexer = find_lexer(ext, path, content)

      formatter = Rouge::Formatters::HTMLTable.new(
        Rouge::Formatters::HTML.new,
        table_class:  "rouge-table",
        gutter_class: "rouge-gutter gl",
        code_class:   "rouge-code"
      )
      table = formatter.format(lexer.lex(content))
      name  = CGI.escapeHTML(display_name || File.basename(path))

      # 结构与 kramdown + rouge 的默认输出一致：
      # <div class="language-x highlighter-rouge">
      #   <div class="highlight">
      #     <pre class="highlight"><code><table class="rouge-table">...</table></code></pre>
      #   </div>
      # </div>
      %(<div file="#{name}" class="language-#{lexer.tag} highlighter-rouge">) +
        %(<div class="highlight"><pre class="highlight"><code>#{table}</code></pre></div>) +
        %(</div>)
    end

    def find_lexer(ext, path, content)
      Rouge::Lexer.find(ext.delete_prefix(".")) ||
        guess_lexer(path) ||
        Rouge::Lexer.find_fancy("html", content) ||
        Rouge::Lexers::PlainText
    end

    def guess_lexer(path)
      result = Rouge::Lexer.guess_by_filename(File.basename(path))
      result.is_a?(Array) ? result.first : result
    rescue StandardError
      nil
    end

    # ---------- 预览 ----------

    def previewable?(site, path = @path)
      return false unless PREVIEW_EXTS.include?(File.extname(path).downcase)
      return false if @opts.key?("nopreview")
      # WEB-INF 下的资源受容器保护，外部无法直接访问，不提供预览
      mapped = mapped_relative(site, path)
      return false if mapped && mapped.split("/").first == "WEB-INF"
      true
    end

    def render_preview(context, site, code, full)
      assets    = assets_for(context)
      raw_url   = preview_url(site, full)
      external  = external_url?(raw_url)
      url       = CGI.escapeHTML(raw_url)
      name      = CGI.escapeHTML(File.basename(full))
      pv_first  = @opts.key?("preview")

      # 站外预览且有回退地址 → iframe 初始留空，JS 探测云端后加载
      fallback   = preview_fallback_url(site, full)
      has_fb     = external && fallback
      iframe_src = has_fb ? "about:blank" : url
      fb_attr    = has_fb ? %( data-fallback="#{CGI.escapeHTML(fallback)}") : ""

      code_sel = pv_first ? "false" : "true"
      pv_sel   = pv_first ? "true"  : "false"
      code_cls = pv_first ? ""      : "isrc-active"
      pv_cls   = pv_first ? "isrc-active" : ""
      code_hid = pv_first ? " hidden" : ""
      pv_hid   = pv_first ? "" : " hidden"

      open_link = if external
        %(<a class="isrc-open" href="#{url}" target="_blank" rel="noopener">新窗口打开 ↗</a>)
      else
        ""
      end

      <<~HTML
        <div class="isrc">#{assets}
          <div class="isrc-tabs" role="tablist">
            <button type="button" role="tab" aria-selected="#{code_sel}"
                    class="isrc-tab #{code_cls}" data-view="code">源码</button>
            <button type="button" role="tab" aria-selected="#{pv_sel}"
                    class="isrc-tab #{pv_cls}" data-view="preview">预览</button>
            #{open_link}
          </div>
          <div class="isrc-pane isrc-code" role="tabpanel"#{code_hid}>#{code}</div>
          <div class="isrc-pane isrc-preview" role="tabpanel"#{pv_hid}>
            <iframe src="#{iframe_src}" data-src="#{url}"#{fb_attr} loading="lazy"
                    sandbox="allow-scripts allow-same-origin allow-forms allow-popups"
                    title="#{name} 预览"></iframe>
          </div>
        </div>
      HTML
    end

    # 同一 page 只注入一次 ASSETS；写入失败则退化为每次注入（JS 幂等守护）
    def assets_for(context)
      page = context.registers[:page]
      return ASSETS if page.nil?

      already = begin
        page[ASSETS_FLAG]
      rescue StandardError
        nil
      end
      return "" if already

      begin
        page[ASSETS_FLAG] = true
      rescue StandardError
        # 不支持写入就退化为每次注入
      end
      ASSETS
    end

    # ---------- URL 推导 ----------

    # 1) 文件位于 webapp_root 下且配置了站外根地址 → 站外 URL（JSP/Tomcat 场景）；
    # 2) 否则在 site.pages 中（尊重 permalink）则用它；否则按静态路径直接拼。
    def preview_url(site, full)
      rel      = full.sub(/\A#{Regexp.escape(site.source)}\/?/, "")
      external = external_preview_url(site, rel)
      return external if external

      target = page_index(site)[rel]
      url    = target ? target.url : "/#{rel}"
      url    = encode_url(url) unless url.ascii_only?
      "#{site.baseurl.to_s.chomp("/")}/#{url.sub(%r{\A/}, "")}"
    end

    # jsp-src/src/main/webapp/lab1/info/index.jsp
    #   → http://localhost:8080/jsp-base/lab1/info/index.jsp
    # 未配置 preview_base，或文件不在 webapp_root 下时返回 nil
    def external_preview_url(site, rel)
      base = preview_base(site)
      return nil unless base
      return nil unless base =~ %r{\Ahttps?://}

      mapped = mapped_relative(site, rel)
      return nil unless mapped
      "#{base}/#{encode_url(mapped)}"
    end

    # 文件相对站点根的路径 → 相对 webapp 根的路径；不在 webapp_root 下返回 nil
    def mapped_relative(site, path_or_rel)
      root = webapp_root(site)
      return nil if root.empty?
      rel  = path_or_rel
      if File.absolute_path(rel).start_with?(site.source)
        rel = rel.sub(/\A#{Regexp.escape(site.source)}\/?/, "")
      end
      return nil unless rel.start_with?("#{root}/") || rel == root
      rel.sub(%r{\A#{Regexp.escape(root)}/?}, "")
    end

    # 标签参数 base= 优先，其次 _config.yml: include_source.preview_base
    def preview_base(site)
      raw = @opts["base"] || isrc_config(site)["preview_base"]
      raw.to_s.strip.sub(%r{/+\z}, "")
    end

    # 标签参数 fallback= 优先，其次 _config.yml: include_source.preview_base_fallback
    def preview_base_fallback(site)
      raw = @opts["fallback"] || isrc_config(site)["preview_base_fallback"]
      raw.to_s.strip.sub(%r{/+\z}, "")
    end

    # 回退预览 URL：与 external_preview_url 同构，用 preview_base_fallback
    def preview_fallback_url(site, full)
      base = preview_base_fallback(site)
      return nil unless base =~ %r{\Ahttps?://}

      rel    = full.sub(/\A#{Regexp.escape(site.source)}\/?/, "")
      mapped = mapped_relative(site, rel)
      return nil unless mapped
      "#{base}/#{encode_url(mapped)}"
    end

    # _config.yml: include_source.webapp_root（相对站点根，不带首尾 /）
    def webapp_root(site)
      isrc_config(site)["webapp_root"].to_s.strip.delete_prefix("/").sub(%r{/+\z}, "")
    end

    def isrc_config(site)
      cfg = site.config["include_source"]
      cfg.is_a?(Hash) ? cfg : {}
    end

    def external_url?(url)
      url =~ %r{\Ahttps?://} ? true : false
    end

    # site.pages 建一次索引，避免每次线性查找
    def page_index(site)
      cached = site.instance_variable_get(:@isrc_pages)
      return cached if cached

      idx = {}
      site.pages.each do |p|
        idx[p.path]          = p if p.respond_to?(:path)
        idx[p.relative_path] = p if p.respond_to?(:relative_path)
      end
      site.instance_variable_set(:@isrc_pages, idx)
      idx
    end

    def encode_url(url)
      url.split("/").map { |s| URI.encode_www_form_component(s).gsub("+", "%20") }.join("/")
    end

    # ---------- 错误输出 ----------

    def err(msg)
      "<!-- #{ERR_PREFIX}#{CGI.escapeHTML(msg)} -->"
    end
  end
end

Liquid::Template.register_tag("include_source", Jekyll::IncludeSourceTag)