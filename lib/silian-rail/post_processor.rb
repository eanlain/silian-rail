module SilianRail
  class PostProcessor
    COMMENT_PATTERN = Regexp.new("<!---->|<!--[^\\[].*?-->", Regexp::MULTILINE | Regexp::IGNORECASE)

    def initialize(context)
      @context = context
      @current_directory = File.dirname(context.pathname)
      @import_assets = []

      @remove_link_imports = Loofah::Scrubber.new do |node|
        if (node.name == 'link') && (node['rel'] == 'import')
          @import_assets.push get_asset_abs_path(node['href'])

          node.remove
        end
      end
    end

    def call(data)
      data = scrub_link_imports(data)
      require_import_assets

      data.to_s.gsub(COMMENT_PATTERN, '')
    end

    private

    def get_asset_abs_path(relative_path)
      File.absolute_path(relative_path, @current_directory)
    end

    def require_import_assets
      @import_assets.each { |asset| @context.require_asset(asset) }
    end

    def scrub_link_imports(data)
      Loofah.scrub_fragment(data, @remove_link_imports)
    end
  end
end
