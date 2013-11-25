class Event < ActiveRecord::Base
  FEE_PASS_ON=0x00
  FEE_SPLIT=0x01
  FEE_TAKE_ON= 0x02

  # Relations
  belongs_to :user
  has_many :tickets
  has_one :category, as: :primary_category
  has_one :category, as: :secondary_category
  has_and_belongs_to_many :age_groups

  # Scopes
  scope :in_future, -> (time = DateTime.now) { where('date_start > ?', time) }
  scope :in_past,   -> (time = DateTime.now) { where('date_start < ?', time) }

  # Validations
  validates_presence_of :name, allow_blank: true, allow_nil: false
  validates_presence_of :date_end, allow_blank: true, allow_nil: false
  validates_presence_of :date_start, allow_blank: true, allow_nil: false
  validates_presence_of :description, allow_blank: true, allow_nil: false
  validates_presence_of :address, allow_blank: true, allow_nil: false

  # Concerns
  include Searchable
  include Geocodable
end
