class OwnerPolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    true
  end

  def create?
    new?
  end

  def index?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
