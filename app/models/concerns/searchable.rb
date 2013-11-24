module Searchable
  extend ActiveSupport::Concern

  included do
    include Tire::Model::Search
    include Tire::Model::Callbacks
  
    index_name "portcullius-#{Rails.env}"
  end
end
