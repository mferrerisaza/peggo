class BuildingPolicy < ApplicationPolicy
  def show
    record.user == current_user
  end

  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
end
