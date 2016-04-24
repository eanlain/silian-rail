# SilianRail

SilianRail extends [Sprockets](https://github.com/rails/sprockets) to allow you to import [Web Components](http://webcomponents.org/) into the [Rails Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html).

## Installation

Add the following line to your Rails application's Gemfile:

    gem 'silian-rail'

Run the bundle command:

    $ bundle

And generate a manifest file by running:

    $ rails generate silian_rail:install

The generator will create a components folder and manifest file at `app/assets/components/application.html`.

Finally, insert the following tag into your application layout:

    <%= html_include_tag 'application' %>

## Usage

Use the Sprockets [`require`](https://github.com/rails/sprockets#the-require-directive) Directive within the components manifest file to pull in a web component and its dependencies.

When referencing a web component (i.e. the Polymer [paper-card](https://elements.polymer-project.org/elements/paper-card) component) you must reference the actual HTML file like so:

      *= require paper-card/paper-card

The require directive will search your assets paths (`app/assets`, `lib/assets`, and `vendor/assets` by default) for the directory and file. Once the directory/file is found, the component, along with any dependencies defined within, is pulled into the asset pipeline.

## Contributing

1. Fork it ( http://github.com/eanlain/silian-rail/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
