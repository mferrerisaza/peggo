class BudgetsController < ApplicationController
  before_action :set_building, only: :index

  def index
    authorize @building, :building_of_current_user?
    @active_budget = Budget.where(building: @building).where(status: true)
    @other_budgets = policy_scope(Budget.where(building: @building)).where(status: false)
  end
end
