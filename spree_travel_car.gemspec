# encoding: UTF-8

require 'yaml'
yaml = YAML.load(File.read('SPREE_TRAVEL_VERSIONS'))
versions = yaml['gems']

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_travel_car'
  s.version     = '4.0.0'
  s.summary     = 'Rent a car into spree'
  s.description = 'Rent a cat into spree'
  s.required_ruby_version = '>= 2.6.5'

  s.authors = 'Sancho, Pedro, Raul, Cesar'
  s.email = 'rperezalejo@gmail.com'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_travel_core', '~> ' + versions['spree_travel']
end
