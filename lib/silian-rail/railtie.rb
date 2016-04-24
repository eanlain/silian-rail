module SilianRail
  class Railtie < ::Rails::Railtie

    config.assets.configure do |env|
      require 'sprockets/directive_processor'
      env.register_preprocessor 'text/html', Sprockets::DirectiveProcessor.new(
        comments: [['<!--', '-->']]
      )

      require 'sprockets/bundle'
      env.register_bundle_processor 'text/html', Sprockets::Bundle

      env.logger = Rails.logger
    end
  end
end
