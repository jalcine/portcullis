class Event < ActiveRecord::Base
  include Searchable
  belongs_to :user
  has_many :tickets
end
