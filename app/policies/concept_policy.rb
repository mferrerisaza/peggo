class ConceptPolicy < ApplicationPolicy
  def edit?
    record.bill.share.owner.user == user
  end
  def update?
    edit?
  end
end
