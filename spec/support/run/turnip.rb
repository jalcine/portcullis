require 'turnip/rspec'
require 'turnip/capybara'

RSpec.configure do | config |
  Dir.glob('spec/acceptance/steps/*.rb') do | file |
    load file
  end
end
