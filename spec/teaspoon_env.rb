ENV["RAILS_ROOT"] = File.expand_path("../../", __FILE__)
require File.expand_path("../../config/environment", __FILE__)

Teaspoon.setup do |config|
  # Behaviors
  config.server_timeout = 20 # timeout for starting the server
  config.server_port = 4374 # defaults to any open port unless specified
  config.fail_fast = true # abort after the first failing suite

  # Output
  config.formatters = "tap"
  config.suppress_log = false
  config.color = true

  # Coverage
  config.coverage = false
  config.coverage_reports = "text,html,cobertura"
  config.coverage_output_dir = "coverage"
  config.statements_coverage_threshold = 50
  config.functions_coverage_threshold = 50
  config.branches_coverage_threshold = 50
  config.lines_coverage_threshold = 50
end
