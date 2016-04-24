module SilianRail
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc 'Copies a HTML manifest to app/assets/components/application.html'

      def copy_component_manifest
        copy_file 'component_manifest.html', 'app/assets/components/application.html'
      end
    end
  end
end
