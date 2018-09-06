class OwnerPolicy < ApplicationPolicy
  def show?
    record.user == user
  end

  def delete?
    show?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
