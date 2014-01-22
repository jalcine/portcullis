class Event < ActiveRecord::Base
  FEE_SPLIT   = 0x0001
  FEE_TAKE_ON = 0x0002
  FEE_PASS_ON = 0x0003

  # Relations
  belongs_to :owner, class_name: User, foreign_key: :user_id
  has_many :tickets, inverse_of: :event
  has_one :primary_category, class_name: Category
  has_one :second_category, class_name: Category 
  has_and_belongs_to_many :age_groups
  accepts_nested_attributes_for :tickets, allow_destroy: true
  resourcify
  has_paper_trail
  mount_uploader :banner, EventBannerUploader

  # Scopes
  scope :in_future,  -> (time = Time.zone.now) { where('date_start > ?', time) }
  scope :in_past,    -> (time = Time.zone.now) { where('date_start < ?', time) }
  scope :yesterday,  -> { where(date_start: (Time.zone.now - 1.day)..Time.zone.now) }
  scope :last_month, -> { where(date_start: (Time.zone.now.midnight - 1.month)..Time.zone.now.midnight) }
  scope :last_week,  -> { where(date_start: (Time.zone.now.midnight - 1.week)..Time.zone.now.midnight) }
  scope :last_year,  -> { where(date_start: (Time.zone.now.midnight - 1.year)..Time.zone.now.midnight) }
  scope :public,     -> { where(publicity: true) }

  # Validations
  validates_presence_of :name, allow_blank: true, allow_nil: false
  validates_presence_of :date_end, allow_blank: true, allow_nil: false
  validates_presence_of :date_start, allow_blank: true, allow_nil: false
  validates_presence_of :description, allow_blank: true, allow_nil: false
  validates_presence_of :address, allow_blank: true, allow_nil: false
  validates_presence_of :fee_processing, allow_blank: false, allow_nil: false

  # Concerns
  include Searchable
  include Geocodable
  resourcify

  def public?
    publicity == :public
  end

  def publicity
    case read_attribute(:publicity)
    when true
      return :public
    when false
      return :unlisted
    end

    :public
  end

  def publicity=(public_state)
    case public_state
      when :unlisted
        write_attribute :publicity, false 
      when :public
        write_attribute :publicity, true
      else
        write_attribute :publicity, true
    end
  end

  def unlisted?
    !public?
  end

  def expired?
    Time.zone.now > date_start && Time.zone.now > date_end
  end

  def elapsing?
    Time.zone.now > date_start && Time.zone.now < date_end
  end

  def draft?
    [:name, :date_end, :date_start, :description, :address, 
      :longitude, :latitude, :primary_category_id, 
      :secondary_category_id].each do | field |
      return true if read_attribute(field).nil?
    end
    return true if tickets.empty?
    false
  end

  def attendees
    # TODO: Get the users who have completed orders for tickets of this event.
    # User.includes(:orders, :tickets).where(ticket: {event: })
  end
end
