class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :read, Inventory
    can :read, Recipe
    can :manage, Inventory, user_id: user.id
    can :manage, Recipe, user_id: user.id
  end
end
