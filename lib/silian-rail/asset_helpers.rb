module ActionView
  module Helpers
    module AssetTagHelper
      def html_include_tag(*sources)
        options = sources.extract_options!.stringify_keys
        integrity = compute_integrity?(options)

        if options['debug'] != false && request_debug_assets?
          sources.map { |source|
            if asset = lookup_debug_asset(source, type: :html)
              if asset.respond_to?(:to_a)
                asset.to_a.map do |a|
                  construct_html_include_tag(path_to_html(a.logical_path, debug: true), options)
                end
              else
                construct_html_include_tag(path_to_html(asset.logical_path, debug: true), options)
              end
            else
              construct_html_include_tag(source, options)
            end
          }.flatten.uniq.join("\n").html_safe
        else
          sources.map { |source|
            options = options.merge('integrity' => asset_integrity(source, type: :html)) if integrity
            construct_html_include_tag source, options
          }.join("\n").html_safe
        end
      end

      def construct_html_include_tag(*sources)
        options = sources.extract_options!.stringify_keys
        path_options = options.extract!('protocol', 'extname', 'host').symbolize_keys
        sources.uniq.map { |source|
          tag_options = {
            'rel' => 'import',
            'href' => path_to_html(source, path_options)
          }.merge!(options)
          tag(:link, tag_options)
        }.join("\n").html_safe
      end
    end

    module AssetUrlHelper
      ASSET_EXTENSIONS.merge!({ html: '.html' })
      ASSET_PUBLIC_DIRECTORIES.merge!({ html: '/components' })

      # Computes the path to a HTML asset in the public components directory.
      def html_path(source, options = {})
        path_to_asset(source, {type: :html}.merge!(options))
      end
      alias_method :path_to_html, :html_path # aliased to avoid conflicts with a html_path named route
    end
  end
end
