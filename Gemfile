# vim: ft=ruby fdm=indent
source 'https://rubygems.org'
ruby '2.0.0'

# We use Rails 4. We bout that life.
gem 'rails', '4.0.0'

# PostgreSQL. All day.
gem 'pg', '0.17.0'

# Unicode normalization in Ruby/jRuby
gem 'unf', '~> 0.1.3'

gem 'haml', '4.0.3'
gem 'haml-rails', '~> 0.4'
gem 'sprockets-image_compressor'
gem 'foundation-rails', '~> 5.0.2', git: 'git://github.com/jalcine/foundation-rails'
gem 'compass-rails', '~> 1.1.2'
gem 'sass-rails', '4.0.0'
gem 'font-awesome-sass', '~> 4.0.1'
gem 'jquery-rails-cdn', '~> 1.0.1'
gem 'underscore-rails', '~> 1.5.2'
gem 'backbone-on-rails', '~> 1.1.0.0'
gem 'modernizr-rails', '~> 2.7.0'
gem 'coffee-rails', '4.0.0'
gem 'tinymce-rails', git: 'git://github.com/spohlenz/tinymce-rails', branch: 'tinymce-4'
gem 'jbuilder', '~> 1.5.2'
gem 'yajl-ruby', '~> 1.1.0'
gem 'attr_encrypted', '~> 1.3.1'
gem 'uglifier', '2.3.0'
gem 'geocoder', '~> 1.1.0'
gem 'browser', '~> 0.3.2'
gem 'devise', '~> 3.0.0rc'
gem 'omniauth', '~> 1.1.4'
gem 'omniauth-facebook', '~> 1.4.1'
gem 'omniauth-gplus', '~> 1.2.0'
gem 'omniauth-linkedin-oauth2', '~> 0.1.4'
gem 'friendly_id', '~> 5.0.1'
gem 'bcrypt-ruby', '~> 3.1.2'
gem 'newrelic_rpm', '~> 3.6.8'
gem 'kaminari', '~> 0.14.1'
gem 'nokogiri', '~> 1.6.0'
gem 'braintree', '~> 2.28.0'
gem 'rails_12factor', '~> 0.0.2', group: [:production]
gem 'cancan', '~> 1.6.10'
gem 'carrierwave', '~> 0.9.0'
gem 'carrierwave-processing', '~> 0.0.2'
gem 'rolify', '~> 3.3.0.rc4'
gem 'rmagick', '~> 2.13.2'
gem 'dotenv-rails', '~> 0.9.0'
gem 'unicorn-rails'
gem 'fog'
#gem 'sidekiq'
#gem 'sidekiq-middleware'
gem 'pry', '0.9.12.2'
gem 'rails_config'
gem 'sdoc', require: false, group: [:doc]
gem 'rack-contrib', git: 'git://github.com/jalcine/rack-contrib.git'
gem 'linkedin', '~> 0.4.4'
gem 'rails-timeago', '~> 2.0'
#gem 'gretel'
#gem 'turnout'
#gem 'rqrcode-rails3'
#gem 'vanity'
#gem 'icalendar'
gem 'rack-referrals'
gem 'rack-attack'
gem 'paper_trail', '~> 3.0.0'
gem 'airbrake', '~> 3.1.15'

group :development do
  #gem 'rails_best_practices', '~> 1.1.4'
  gem 'erb2haml', '~> 0.1.5', require: false
  gem 'pry-rails', '~> 0.3.2'
  gem 'CoffeeTags', require: false
  gem 'debugger', '~> 1.6.2'
  gem 'debugger-xml', '~> 0.3.3'
  gem 'binding_of_caller', '~> 0.7.2'
  gem 'guard', '2.2.2'
  gem 'guard-bundler', '~> 2.0.0', require: false
  gem 'guard-migrate', '~> 0.2.1', require: false
  gem 'guard-ctags-bundler', '~> 1.0.1', require: false
  gem 'guard-livereload', '~> 2.0.0', require: false
  gem 'chrome_logger', '~> 0.1.2', require: 'chrome_logger/railtie'
  gem 'guard-rspec', '~> 4.0.0', require: false
  gem 'guard-sidekiq', '~> 0.0.11', require: false
  gem 'guard-spork', '~> 1.5.1', require: false
  gem 'guard-rails', '~> 0.4.7', require: false
  #gem 'guard-teaspoon', '~> 0.0.4', require: false
  gem 'rack-livereload', '~> 0.3.15', require: false
  #gem 'bullet'
  gem 'quiet_assets', '~> 1.0.2'
  gem 'better_errors', '~> 1.0.1'
  gem 'jazz_hands', '~> 0.5.2'
  gem 'meta_request', '~> 0.2.8'
  gem 'coffee-rails-source-maps'
  #gem 'railroady'
end

# Set up testing.
group :test, :development do
  gem 'ci_reporter', '~> 1.9.0'
  gem 'fake_braintree', '~> 0.4.0', require: false
  #gem 'ejs', '~> 1.1.1'
  #gem 'teaspoon', '~> 0.7.8'
  #gem 'tapout', '~> 0.4.5'
  gem 'awesome_print', '~> 1.2.0'
  gem 'faker', '~> 1.1.2', require: false
  gem 'rspec', '~> 2.14', require: false
  gem 'rspec-rails', '~> 2.14', require: false
  gem 'rspec-mocks', '~> 2.14', require: false
  gem 'rspec-expectations', '~> 2.14', require: false
  gem 'database_cleaner', '~> 1.2.0', require: false
  gem 'spork-rails', '~> 4.0.0', require: false
  gem 'factory_girl_rails', '~> 4.2.1', require: false
  gem 'capybara', require: false
  gem 'capybara-screenshot', require: false
  gem 'poltergeist', require: false
  gem 'turnip', require: false
  gem 'libnotify', require: false
  gem 'growl', require: false
  gem 'rb-inotify', require: false
  gem 'rb-fsevent', require: false
  gem 'simplecov', require: false
  gem 'simplecov-html', require: false
  gem 'nyan-cat-formatter', require: false
end
