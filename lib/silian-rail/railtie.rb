module SilianRail
  class Railtie < ::Rails::Railtie

    config.assets.configure do |env|
      require 'sprockets/directive_processor'
      env.register_preprocessor 'text/html', Sprockets::DirectiveProcessor.new(
        comments: [['<!--', '-->']]
      )

      require 'silian-rail/post_processor'
      env.register_postprocessor 'text/html', :web_components do |context, data|
        SilianRail::PostProcessor.new(context).call(data)
      end

      require 'sprockets/bundle'
      env.register_bundle_processor 'text/html', Sprockets::Bundle

      env.logger = Rails.logger
    end
  end
end
