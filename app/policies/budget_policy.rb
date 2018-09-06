class BudgetPolicy < ApplicationPolicy
  def edit?
    record.building.user == user
  end

  def destroy?
    edit?
  end
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
