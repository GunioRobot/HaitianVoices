class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, Story
      can :manage, User
    elsif user.moderator?
      can :manage, Story
    else
      can :read, :all
    end
  end
end