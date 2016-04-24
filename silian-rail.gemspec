$:.unshift File.expand_path('../lib', __FILE__)

require 'silian-rail/version'

Gem::Specification.new do |s|
  s.name        = 'silian-rail'
  s.version     = SilianRail::VERSION
  s.summary     = 'Use Web Components with the Rails Asset Pipeline'
  s.author      = 'Brandon Robins'
  s.email       = 'brandon.robins@onebnottwo.com'
  s.homepage    = 'http://www.github.com/eanlain/silian-rail'
  s.license     = 'MIT'

  s.files       = Dir['lib/**/*', 'LICENSE', 'README.md']
  s.test_files  = Dir['spec/**/*']

  s.add_dependency 'rails', '>= 4.2'
  s.add_dependency 'loofah', '~> 2.0'
end
