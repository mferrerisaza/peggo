class BillPolicy < ApplicationPolicy
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
