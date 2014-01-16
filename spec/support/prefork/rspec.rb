require 'rspec/rails'
require 'rspec/autorun'
require 'rspec/expectations'
require 'rspec/matchers'
require 'awesome_print'

RSpec.configure do | config |
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = :random
  config.filter_run_excluding [:broken, :backlog]
  config.include Rails.application.routes.url_helpers
  config.run_all_when_everything_filtered = true
  config.render_views
  config.expect_with(:rspec) do | ex |
    ex.syntax = [:expect]
  end
end
