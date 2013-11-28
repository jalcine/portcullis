require 'turnip/rspec'
require 'turnip/capybara'

RSpec.configure do | config |
  Dir.glob("#{Rails.root}/spec/acceptance/steps/*.rb") do | file |
    require file
  end
end
