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
    alias_action :edit, to: :update
    alias_action :update, :destroy, to: :modify
    alias_action :create, :read, :update, :destroy, to: :crud
  end

  def general
    can :view, Event
    can :view, Ticket
  end

  def guest
    can :view, Event
    can :view, Order do | order |
      order.user == @user
    end
    can :order, Ticket do | ticket |
      ticket.available?
    end
  end

  def administrator
    can :manage, :all
  end

  def host
    can :create, Event
    can [:crud, :modify], Event, {owner: @user}

    can :crud, Ticket do | ticket |
      can? :crud, ticket.event
    end
    can :modify, Ticket do | ticket |
      can? :modify, ticket.event
    end

    can :crud, Order do | order |
      can? :modify, order.ticket
    end
  end

  def attendee
    can :view, Ticket
    can :order, Ticket do | ticket |
      !ticket.expired?
    end

    can :view, Order do | order |
      return true if @user.has_role?(:host, order.ticket.event)
      order.user == @user
    end

    can :rsvp, Event do | event |
      # TODO: Check if users have ordered already.
      !event.expired?
    end

    can :create, Order
    can :modify, Order do | order |
      return false if can? :update, order.ticket
      !order.ticket.expired?
    end

    can :cancel, Order do | order |
      !order.ticket.expired? or cannot?(:modify, order)
    end
  end
end
