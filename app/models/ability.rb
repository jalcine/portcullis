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
    alias_action :read, to: :view
    alias_action :show, to: :view
    alias_action [:update, :destroy], to: :modify
    alias_action [:create, :read, :update, :destroy], to: :crud
  end

  def guest
    cannot :crud, Event
    cannot :crud, Ticket
    cannot :crud, Order
    can :view, Event
    can :view, Ticket
  end

  def administrator
    guest
    host
    attendee
    can :manage, Event
    can :manage, Ticket
    can :manage, Order
    can :manage, User
  end

  def host
    guest
    can [:crud, :modify], Event do | event |
      event.owner == @user
    end

    can [:crud, :modify], Ticket do | ticket |
      ticket.event.owner == @user
    end

    can [:update, :create], Order do | order |
      order.user == @user && order.ticket.event.owner != @user
    end
  end

  def attendee
    # TODO: Check if users are banned?
    # TODO: Check if users have ordered already.
    can :rsvp, Event do |event|
      !event.expired?
    end

    can [:update, :destory], Order do | order |
      order.user == @user && order.ticket.event.owner != @user
    end
  end
end
