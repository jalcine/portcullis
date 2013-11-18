require 'rspec/rails'
require 'rspec/autorun'
require 'rspec/expectations'
require 'rspec/matchers'

RSpec.configure do | config |
  config.order = :random
  config.include Rails.application.routes.url_helpers
  config.render_views
  config.expect_with(:rspec) do | ex |
    ex.syntax = [:expect]
  end
  config.filter_run_excluding broken: true
  config.run_all_when_everything_filtered = true
end
