require 'turnip/rspec'
require 'turnip/capybara'
require 'turnip/kanban'

RSpec.configure do | config |
  Dir.glob("#{Rails.root}/spec/acceptance/steps/*.rb") do | file |
    require file
  end
end
