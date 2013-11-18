module Roleable
  extend ActiveSupport::Concern

  included do
    rolify
    before_save :ensure_a_role_is_present
  end

  def ensure_a_role_is_present
    self.add_role 'guest' if self.roles.empty?
  end

  public
  def role
    ensure_a_role_is_present if self.roles.empty?
    self.roles.first.name
  end
end
