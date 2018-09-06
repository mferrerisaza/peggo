class SharePolicy < ApplicationPolicy
  def destroy?
    record.owner.user == user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
