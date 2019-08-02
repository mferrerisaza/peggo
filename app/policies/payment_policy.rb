class PaymentPolicy < ApplicationPolicy
  def show?
    record.business.user == user
  end

  def edit?
    show?
  end

  def destroy?
    show?
  end

  def print?
    show?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
