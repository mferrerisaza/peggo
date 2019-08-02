class AttachmentPolicy < ApplicationPolicy
  def show?
    return record.expense.business.user == user if record.expense
    return record.invoice_equivalent.business.user == user if record.invoice_equivalent
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
