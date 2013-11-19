class Event < ActiveRecord::Base
  belongs_to :user
  has_many :tickets

  # Scopes
  scope :in_future, -> (time = DateTime.now) { where('date_start > ?', time) }
  scope :in_past,   -> (time = DateTime.now) { where('date_start < ?', time) }
end
