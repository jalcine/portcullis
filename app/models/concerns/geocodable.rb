module Geocodable 
  extend ActiveSupport::Concern

  included do
    geocoded_by :address, if: -> (obj) { obj.address_changed? }
    reverse_geocoded_by :latitude, :longitude

    after_validation :reverse_geocode, 
      if: -> (obj) { (obj.latitude_changed? or obj.longitude_changed?) and !obj.address_changed? }
  end
end
