class ExpensesController < ApplicationController
  before_action :set_building, except: :update
  before_action :set_expense, only: %i[show edit update destroy]

  def index
    @expenses = policy_scope(Expense.where(building: @building).order(created_at: :asc))
  end

  def show
    @attachments = @expense.attachments
    authorize @expense
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

  def edit
    authorize @building, :building_of_current_user?
  end

  def update
    @building = Building.find(expense_params[:building_id])
    authorize @building, :building_of_current_user?
    if @expense.update(expense_params)
      flash[:notice] = "Egreso actualizado existosamente"
      redirect_to building_expenses_path @building
    else
      render 'edit'
    end
  end

  private

  def expense_params
    strong_params = params.require(:expense).permit(:beneficiary, :payment_method, :date, :description, :amount, :building_id, :observation, attachments_attributes: [:id, :file, "@original_filename", "@content_type", "@headers", "_destroy"])
    strong_params[:amount] = strong_params[:amount].gsub(".", "") if strong_params[:amount]
    strong_params[:attachments_attributes].each { |attachment| attachment[:name] = attachment[:file].original_filename } if strong_params[:attachments_attributes].is_a?(Array)
    strong_params
  end

  def set_expense
    @expense = Expense.find(params[:id])
  end

end
