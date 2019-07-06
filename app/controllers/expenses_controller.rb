class ExpensesController < ApplicationController
  before_action :set_business, except: :update
  before_action :set_expense, only: %i[show edit update destroy print]

  def index
    @expenses = policy_scope(Expense.where(business: @business).order(created_at: :asc).includes(:contact))
  end

  def show
    @attachments = @expense.attachments
    authorize @expense
  end

  def new
    @expense = Expense.new
    authorize @business, :business_of_current_user?
  end

  def create
    @expense = Expense.new(expense_params)
    authorize @business, :business_of_current_user?
    if @expense.save
      flash[:notice] = "Egreso creado existosamente"
      redirect_to business_expense_path @business, @expense
    else
      render :new
    end
  end

  def edit
    authorize @business, :business_of_current_user?
  end

  def update
    @business = Business.find(expense_params[:business_id])
    authorize @business, :business_of_current_user?
    if @expense.update(expense_params)
      flash[:notice] = "Egreso actualizado existosamente"
      redirect_to business_expense_path @business, @expense
    else
      render 'edit'
    end
  end

  def destroy
    authorize @expense
    @expense.destroy
    flash[:notice] = "Egreso eliminado existosamente"
    redirect_to business_expenses_path(@business)
  end

  def print
    authorize @expense
    @contact = @expense.contact
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: @expense.pdf_file_name, layout: 'pdf.html', show_as_html: params.key?('debug')   # Excluding ".pdf" extension.
      end
    end
  end

  private

  def expense_params
    strong_params = params.require(:expense).permit(:number, :contact_id, :payment_method, :date, :description, :amount, :business_id, :observation, attachments_attributes: [:id, :file, "@original_filename", "@content_type", "@headers", "_destroy"])
    strong_params[:amount] = strong_params[:amount].gsub(",", "") if strong_params[:amount]
    strong_params[:attachments_attributes].each { |attachment| attachment[:name] = attachment[:file].original_filename } if strong_params[:attachments_attributes].is_a?(Array)
    strong_params
  end

  def set_expense
    @expense = Expense.includes(:contact).find(params[:id])
  end

end
