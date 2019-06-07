class ExpensePolicy < ApplicationPolicy
  def show?
    record.building.user == user
  end

  def destroy?
    show?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
