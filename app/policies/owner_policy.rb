class OwnerPolicy < ApplicationPolicy
  def show?
    record.user == user
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
