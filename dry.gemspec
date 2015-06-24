require File.expand_path('../lib/dry/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'dry'
  s.version     = Dry::VERSION
  s.summary     = 'Dry'
  s.description = 'Dry'
  s.license     = 'BSD-3-Clause'
  #s.homepage    = 'https://rubygems.org/gems/dry'

  s.authors     = 'Thibault Jouan'
  s.email       = 'tj@a13.fr'

  s.files       = `git ls-files lib`.split $/

  s.add_dependency 'railties', '~> 4.2.2'
end
