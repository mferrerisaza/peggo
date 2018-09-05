class BudgetsController < ApplicationController
  before_action :set_building, only: :index

  def index
    @bugets = policy_scope(Budget.where(building: @building))
    authorize @building, :building_of_current_user?
  end
end
