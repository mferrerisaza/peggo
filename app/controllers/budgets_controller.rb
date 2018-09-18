class BudgetsController < ApplicationController
  before_action :set_building, except: :show
  before_action :set_budget, only: %i[edit update destroy]

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
    if @budget.save
      flash[:notice] = "Presupuesto creado con éxito"
      redirect_to building_budgets_path @building
    else
      render 'new'
    end
  end

  def edit
    authorize @budget
  end

  def update
    # @building = Building.find(budget_params[:building_id])
    authorize @building, :building_of_current_user?
    if @budget.update(budget_params)
      redirect_to building_budgets_path @building
    else
      render 'edit'
    end
  end

  def destroy
    authorize @budget
    @budget.destroy
    flash[:notice] = "Presupuesto eliminado con éxito"
    redirect_to building_properties_path(@building)
  end

  private

  def budget_params
    params.require(:budget).permit(:start_date, :end_date, :building_id, :amount, :status)
  end

  def set_budget
    @budget = Budget.find(params[:id])
  end
end
