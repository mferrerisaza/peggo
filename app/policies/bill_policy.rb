class BillPolicy < ApplicationPolicy

  def new?
    record.user == user
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
