class SharePolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    true
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
