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
    alias_action :show, :view, to: :read
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
    can :rsvp, Event do | event |
      !event.expired?
    end
    can :view, Ticket
    can :order, Ticket do | ticket |
      ticket.available?
    end
    can :create, Order
    can :read, Order do | order |
      # TODO Fix this.
      order.user == @user
    end
    can [:modify, :cancel], Order do | order |
      order.ticket.available? and order.user == @user
    end
  end
end
