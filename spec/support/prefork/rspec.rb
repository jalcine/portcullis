require 'rspec/rails'
require 'rspec/autorun'
require 'rspec/expectations'
require 'rspec/matchers'
require 'awesome_print'

RSpec.configure do | config |
  config.order = :random
  config.include Rails.application.routes.url_helpers
  config.filter_run_excluding broken: true
  config.run_all_when_everything_filtered = true
  config.render_views
  config.expect_with(:rspec) do | ex |
    ex.syntax = [:expect]
  end
end