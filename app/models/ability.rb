class Ability
  include CanCan::Ability

  def initialize(user)
    attach_aliases
    @user = user
    @user ||= User.new
    @user.roles.each { |role| send role.name.to_sym }
    general
    guest if @user.roles.empty?
  end

  def attach_aliases
    alias_action :show, to: [:read, :view]
    alias_action :edit, to: :update
    alias_action [:update, :destroy], to: :modify
    alias_action [:create, :read, :update, :destroy], to: :crud
  end

  def general
    can :view, Event
    can :view, Ticket
  end

  def guest
    cannot :view, Order
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
    can :create, Event
    can [:crud, :modify, :edit], Event.find_by(user_id: @user.id.to_s)

    can :crud, Ticket do | ticket |
      ticket.event.owner == @user
    end

    can :crud, Order do | order |
      puts can? :modify, order.ticket.event
    end
  end

  def attendee
    can :view, Ticket
    can :order, Ticket do | ticket |
      !ticket.expired?
    end

    can :rsvp, Event do | event |
      # TODO: Check if users have ordered already.
      !event.expired?
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
