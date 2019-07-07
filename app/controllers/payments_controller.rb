class PaymentsController < ApplicationController
  before_action :set_business, except: :update
  before_action :set_payment, only: %i[show edit update destroy print]

  def index
    @payments = policy_scope(Payment.where(business: @business).order(created_at: :asc).includes(:contact))
  end

  def show
    authorize @payment
  end

  def new
    @payment = Payment.new
    authorize @business, :business_of_current_user?
  end

  def create
    @payment = Payment.new(payment_params)
    authorize @business, :business_of_current_user?
    if @payment.save
      flash[:notice] = "Pago registrado existosamente"
      redirect_to business_payment_path @business, @payment
    else
      render :new
    end
  end

  def edit
    authorize @business, :business_of_current_user?
  end

  def update
    @business = Business.find(payment_params[:business_id])
    authorize @business, :business_of_current_user?
    if @payment.update(payment_params)
      flash[:notice] = "Pago actualizado existosamente"
      redirect_to business_payment_path @business, @payment
    else
      render 'edit'
    end
  end

  private

  def set_payment
    @payment = Payment.includes(:contact).find(params[:id])
  end

  def payment_params
    strong_params = params.require(:payment).permit(
                                              :number,
                                              :contact_id,
                                              :invoice_id,
                                              :payment_method,
                                              :date,
                                              :description,
                                              :amount,
                                              :retention,
                                              :business_id,
                                              :observation
                                            )
  end
end
