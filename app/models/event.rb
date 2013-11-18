class Event < ActiveRecord::Base
  has_one :location
  belongs_to :user
  has_many :tickets
end
