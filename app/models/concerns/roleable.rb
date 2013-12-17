module Roleable
  extend ActiveSupport::Concern

  included do
    rolify
    before_save :ensure_a_role_is_present
    before_save :remove_guest_role_if_others_are_present
  end

  def ensure_a_role_is_present
    self.add_role :guest if self.roles.empty?
  end

  def remove_guest_role_if_others_are_present
    self.remove_role :guest if self.roles.include? :guest and self.roles.count >= 2
  end

  public
    def role
      ensure_a_role_is_present if self.roles.empty?
      self.roles.first.name
    end
end
