class BusinessPolicy < ApplicationPolicy
  def show?
    record.user == user
  end

  def business_of_current_user?
    record.user == user
  end

  def new?
    true
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
end
