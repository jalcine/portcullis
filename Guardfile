scope groups: [:core, :ui, :test]
notification :libnotify, timeout: 3

group :core do
  guard :bundler do
    watch('Gemfile')
  end

  guard :migrate do
    watch(%r{^db/migrate/(\d+).+\.rb})
    watch('db/seeds.rb')
  end

  guard 'ctags-bundler' do
    watch(/^(app|lib|spec\/support)\/.*\.rb$/)
    watch('Gemfile.lock')
    watch('gem.tags')
  end
end

group :ui do
  guard :rails, port: 4373, daemon: false, debugger: true, server: :unicorn, force_run: true do
    watch('Gemfile.lock')
    watch('config/application.rb')
    watch('config/environment.rb')
    watch('config/unicorn/development.rb')
    watch(%r{^config/(initializers|environments)/.+\.rb$})
    watch(%r{^config/settings/.+\.yml$})
  end 

  guard :livereload, apply_css_live: true, grace_period: 0.1 do
    watch('config/routes.rb')
    watch(%r{app/views/.+\.haml$})
    watch(%r{app/helpers/.+\.rb})
    watch(%r{public/.+\.(css|js|html)})
    watch(%r{config/locales/.+\.yml})
    watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }
  end
end

group :test do
  guard :spork, rspec_env: { RAILS_ENV: :test }, wait: 60, retry_delay: 2 do
    watch('Gemfile.lock')
    watch('config/unicorn/test.rb')
    watch('config/application.rb')
    watch('config/environment.rb')
    watch('config/environments/test.rb')
    watch('spec/spec_helper.rb')
    watch(%r{config/settings/test\.*\.yml})
    watch(%r{^config/initializers/.+\.rb$})
    watch(%w{^spec/support/prefork)/(.+)\.rb$}) { [:spork, 'spec'] }
  end

  guard :konacha, all_on_start: false do
    watch('spec/javascripts/spec_helper.js.coffee') { 'spec/javascripts' }
    watch(%r{^app/assets/javascripts/(.*)\.js(\.coffee)?$}) { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
    watch(%r{^spec/javascripts/.+_spec(\.js|\.js\.coffee)$})
  end

  guard :rspec, all_on_pass: false, keep_failed: false, all_on_start: false, cmd: 'bundle exec rspec --drb' do
    # Global changes
    watch('.rspec')                                     { 'spec' }
    watch('spec/spec_helper.rb')                        { 'spec' }
    watch(%w{^spec/factories/**/*.rb$})                 { 'spec' }
    watch(%w{^spec/support/run/**/*.rb$})               { 'spec' }
    watch('config/routes.rb')                           { 'spec/routing' }
    watch('spec/turnip_helper.rb')                      { 'spec/acceptance'}
    watch('app/controllers/application_controller.rb')  { 'spec/controllers' }
    watch(%r{^spec/factories/(.+)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}.feature"] }

    # Per-file changes
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/views/(.*)\.haml$})                   { |m| "spec/views/#{m[1]}#{m[2]}_spec.rb" }

    # Integration and acceptance testing
    watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$})   { 'spec/acceptance' }
    watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}.feature"] }
    watch(%r{^spec/acceptance/(.+)\.feature$})          { |m| "spec/acceptance/#{m[1]}.feature" }
  end
end
