class Event < ActiveRecord::Base
  # Relations
  belongs_to :user
  has_many :tickets

  # Scopes
  scope :in_future, -> (time = DateTime.now) { where('date_start > ?', time) }
  scope :in_past,   -> (time = DateTime.now) { where('date_start < ?', time) }

  # Validations
  validates_presence_of :name
  validates_presence_of :user
  validates_presence_of :address, allow_nil: true, allow_blank: true
  validates_presence_of :longitude, allow_nil: true, allow_blank: true
  validates_presence_of :latitude, allow_nil: true, allow_blank: true
  validates_presence_of :description, allow_blank: false
  validates_presence_of :date_start
  validates_presence_of :date_end
  validates_uniqueness_of :name

  # Concerns
  include Searchable
  include Geocodable
end
