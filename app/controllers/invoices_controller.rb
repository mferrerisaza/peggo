class InvoicesController < ApplicationController
  before_action :set_business, except: :update
  before_action :set_invoice, only: %i[show edit update destroy print]

  def index
    @invoices = policy_scope(Invoice.where(business: @business).order(created_at: :asc).includes(:contact))
  end

  def show
    @items = @invoice.items
    authorize @invoice
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

  def edit
    authorize @business, :business_of_current_user?
  end

  def update
    @business = Business.find(invoice_params[:business_id])
    authorize @business, :business_of_current_user?
    if @invoice.update(invoice_params)
      respond_to do |format|
        format.html do
          flash[:notice] = "Factura actualizada existosamente"
          redirect_to business_invoices_path @business
        end
        format.js
      end
    else
      @item = Item.new
      render :new
    end
  end

  def destroy
    authorize @invoice
    @invoice.destroy
    flash[:notice] = "Factura eliminada existosamente"
    redirect_to business_invoices_path(@business)
  end

  def print
    authorize @invoice
    @contact = @invoice.contact
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: @invoice.pdf_file_name, layout: 'pdf.html', show_as_html: params.key?('debug')   # Excluding ".pdf" extension.
      end
    end
  end

  private

  def set_invoice
    @invoice = Invoice.includes(:contact).find(params[:id])
  end

  def invoice_params
    strong_params = params.require(:invoice).permit(
                                              :number,
                                              :contact_id,
                                              :date,
                                              :expiration_date,
                                              :signature,
                                              :terms_and_conditions,
                                              :notes,
                                              :resolution_number,
                                              :business_id,
                                              items_attributes: [:id, :name, :quantity, :price, :vat, :discount, "_destroy", "id"]
                                            )
    strong_params[:items_attributes].each {|_key, item| item[:price] = item[:price].gsub(",","") } unless strong_params[:items_attributes][:_destroy] == "true"

    strong_params
  end
end
