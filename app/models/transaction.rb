class Transaction < ActiveRecord::Base
  has_many :orders
  belongs_to :merchant, class_name: User, foreign_key: :merchant_id
end
