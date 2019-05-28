class ExpensesController < ApplicationController
  before_action :set_building

  def index
    @expenses = policy_scope(Expense.where(building: @building).order(created_at: :asc))
  end

  def new
    @expense = Expense.new
    authorize @building, :building_of_current_user?
  end

  def create
    @expense = Expense.new(expense_params)
    authorize @building, :building_of_current_user?
    if @expense.save
      flash[:notice] = "Egreso creado existosamente"
      redirect_to building_expenses_path @building
    else
      render :new
    end
  end

  private

  def expense_params
    strong_params = params.require(:expense).permit(:beneficiary, :payment_method, :date, :description, :amount, :building_id)
    strong_params[:amount] = strong_params[:amount].gsub(",", "")
    strong_params
  end

end
