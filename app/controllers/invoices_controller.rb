class InvoicesController < ApplicationController
  before_action :set_business
  before_action :set_invoice, only: %i[show edit update destroy print]

  def index
    @invoices = policy_scope(Invoice.where(business: @business).order(created_at: :asc).includes(:contact))
  end

  def new
    @invoice = Invoice.new
    @item = Item.new
    authorize @business, :business_of_current_user?
  end

  def create
    @invoice = Invoice.new(invoice_params)
    authorize @business, :business_of_current_user?
    if @invoice.save
      flash[:notice] = "Factura guardada existosamente"
      redirect_to business_invoices_path @business
    else
      @item = Item.new
      render :new
    end
  end

  private

  def set_invoice
    @invoice = Invoice.includes(:contact).find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(
      :number,
      :contact_id,
      :date,
      :signature,
      :terms_and_conditions,
      :notes,
      :resolution_number,
      :business_id,
      items_attributes: [:name, :quantity, :price, :vat, :discount]
    )
  end
end
