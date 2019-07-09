class InvoicePolicy < ApplicationPolicy
  def show?
    record.business.user == user
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
