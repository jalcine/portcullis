class Ability
  include CanCan::Ability

  def initialize(user)
    attach_aliases
    @user = user
    @user ||= User.new
    @user.roles.each { |role| send role.name.to_sym }
    guest if @user.roles.empty?
  end

  def attach_aliases
    alias_action [:read, :show], to: :view
    alias_action :edit, to: :update
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
    can :crud, Event do | event |
      event.owner == @user
    end

    can :crud, Ticket do | ticket |
      ticket.event.owner == @user
    end

    can [:update, :create], Order do | order |
      order.user == @user && order.ticket.event.owner != @user
    end
  end

  def attendee
    # TODO: Check if users are banned?
    can :order, Ticket do | ticket |
      ticket.expired?
    end

    can :rsvp, Event do | event |
      # TODO: Check if users have ordered already.
      event.expired?
    end

    can [:create, :modify], Order do | order |
      return false if @user.has_role? :host, order.ticket.event
      !order.ticket.expired?
    end

    can :cancel, Order do | order |
      !order.ticket.expired? or cannot?(:modify, order)
    end

  end
end
