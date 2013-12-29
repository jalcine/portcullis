Teaspoon.setup do |config|
  config.mount_at = "/teaspoon"
  config.root = nil
  config.asset_paths = ["spec/javascripts", "spec/javascripts/stylesheets"]
  config.fixture_path = "spec/javascripts/fixtures"

  config.suite do |suite|
    suite.matcher = "{spec/javascripts,app/assets}/**/*_spec.{js,js.coffee,coffee}"
    suite.helper = "spec_helper"
    suite.javascripts = ['teaspoon/mocha', 'support/chai']
    suite.stylesheets = ["teaspoon"]
    suite.no_coverage = [%r{/lib/ruby/gems/}, %r{/vendor/assets/}, %r{/support/}, %r{/(.+)_helper.}]
    suite.no_coverage << "jquery.js" # excludes jquery from coverage reports

  end

  config.suite :quirks do |suite|
    suite.matcher = "spec/javascripts/quirks/*_spec.{js,js.coffee,coffee}"
  end
end if defined?(Teaspoon) && Teaspoon.respond_to?(:setup)
