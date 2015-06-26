directories %w[app lib spec]

guard :spork, rspec_env: { RAILS_ENV: 'test' } do
  watch('spec/dummy/config/application.rb')
  watch('spec/dummy/config/environment.rb')
  watch(%r{^spec/dummy/config/environments/.+\.rb$})
  watch(%r{^spec/dummy/config/initializers/.+\.rb$})
  watch('spec/spec_helper.rb')
  watch(%r{^spec/support/.+\.rb$})
end

guard :rspec, cmd: 'bundle exec rspec --drb -f doc' do
  watch(%r{^spec/.+_spec\.rb$})

  watch('spec/spec_helper.rb')          { 'spec' }

  watch('spec/dummy/config/routes.rb')  { 'spec/features' }

  watch(%r{^spec/dummy/app/})           { 'spec/features' }
end
