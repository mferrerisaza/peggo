class BuildingPolicy < ApplicationPolicy
  def show?
    record.user == user
  end

  def show_properties?
    record.user == user
  end

  def new?
    true
  end

  def create?
    new?
  end

  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
end
