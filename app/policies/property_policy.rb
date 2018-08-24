class PropertyPolicy < ApplicationPolicy
  def show?
    record.building.user == user
  end

  def edit?
    show?
  end

  def update?
    edit?
  end

  def destroy?
    show?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
