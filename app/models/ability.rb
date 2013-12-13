class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    attach_aliases
    @user ||= User.new
    @user.roles.each { |role| send role.name.to_sym }
    guest if @user.roles.empty?
  end

  def attach_aliases
    alias_action :update, :destroy, to: :modify
    alias_action :crud, to: :manage
  end

  def guest
    can :view, Event
    can :view, Ticket
  end

  def administrator
    guest
    host
    attendee
    can :manage, Event
    can :manage, Ticket
    can :manage, User
  end

  def host
    guest
    can :create, Event
    can :create, Ticket { |ticket| @user.has_role?(:host, ticket.event) }
    can :modify, Event  { |event| event.owner == @user }
    can :modify, Ticket { |ticket| @user.has_role?(:host, ticket.event) }
  end

  def attendee
    # TODO: Check if users are banned?
    can :rsvp, Event { |event| !event.expired?  }
  end
end
