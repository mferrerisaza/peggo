class BudgetsController < ApplicationController
  before_action :set_building, only: %i[index new create]

  def index
    authorize @building, :building_of_current_user?
    @active_budget = Budget.where(building: @building).where(status: true)
    @other_budgets = policy_scope(Budget.where(building: @building)).where(status: false)
  end

  def new
    authorize @building, :building_of_current_user?
    @budget = Budget.new
  end

  def create
    authorize @building, :building_of_current_user?
    @budget = Budget.new(budget_params)
    @budget.start_date = @budget.start_date.beginning_of_month
    @budget.end_date = @budget.end_date.end_of_month
    if @budget.save
      redirect_to building_budgets_path @building
    else
      render 'new'
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:start_date, :end_date, :building_id, :amount, :status)
  end
end
