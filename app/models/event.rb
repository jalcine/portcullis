class Event < ActiveRecord::Base
  # Relations
  belongs_to :user
  has_many :tickets

  # Scopes
  scope :in_future, -> (time = DateTime.now) { where('date_start > ?', time) }
  scope :in_past,   -> (time = DateTime.now) { where('date_start < ?', time) }

  # Validations
  validates_presence_of :name, allow_blank: false, allow_nil: false
  validates_presence_of :date_end, allow_nil: false, allow_blank: false
  validates_presence_of :date_start, allow_nil: false, allow_blank: false
  validates_presence_of :description, allow_blank: false, allow_nil: false
  validates_presence_of :address
  validates_uniqueness_of :name

  # Concerns
  include Searchable
  include Geocodable
end
