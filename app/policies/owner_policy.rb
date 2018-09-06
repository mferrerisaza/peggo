class OwnerPolicy < ApplicationPolicy
  def show?
    record.user == user
  end

  def new?
    show?
  end

  def create?
    new?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
