class BudgetsController < ApplicationController
  before_action :set_building, only: :index

  def index
    authorize @building, :building_of_current_user?
    @bugets = policy_scope(Budget.where(building: @building))
  end
end
