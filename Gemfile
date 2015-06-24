source 'https://rubygems.org'

gemspec

group :test do
  gem 'spork', github: 'tjouan/spork', branch: 'rspec-3'
end

eval File.read('Gemfile-custom.rb') if File.exist?('Gemfile-custom.rb')
