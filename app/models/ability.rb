# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # Define roles and their corresponding abilities
    can :read, Project
    if user.staff?
      staff_rules
    end
  end

  private

  def staff_rules
    can [:submit, :approve, :reject, :cancel], Project
  end
end
