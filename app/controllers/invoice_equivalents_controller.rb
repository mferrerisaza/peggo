class InvoiceEquivalentsController < ApplicationController
  before_action :set_business, except: :update
  before_action :set_invoice_equivalent, only: %i[show edit update destroy print toggle_printed]

  def index
    @invoice_equivalents = policy_scope(InvoiceEquivalent.where(business: @business).order(number: :desc).includes(:contact).paginate(page: params[:page]))
  end

  def show
    @attachments = @invoice_equivalent.attachments
    authorize @invoice_equivalent
  end

  def new
    @invoice_equivalent = InvoiceEquivalent.new
    authorize @business, :business_of_current_user?
  end

  def create
    @invoice_equivalent = InvoiceEquivalent.new(invoice_equivalent_params)
    authorize @business, :business_of_current_user?
    if @invoice_equivalent.save
      flash[:notice] = "Documento equivalente a factura de venta creado existosamente"
      redirect_to business_invoice_equivalent_path @business, @invoice_equivalent
    else
      render :new
    end
  end

  def edit
    authorize @invoice_equivalent
  end

  def update
    @business = Business.find(invoice_equivalent_params[:business_id])
    authorize @business, :business_of_current_user?
    if @invoice_equivalent.update(invoice_equivalent_params)
      flash[:notice] = "Documento equivalente a factura de venta actualizado existosamente"
      redirect_to business_invoice_equivalent_path @business, @invoice_equivalent
    else
      render 'edit'
    end
  end

  def destroy
    authorize @invoice_equivalent
    @invoice_equivalent.destroy
    flash[:notice] = "Documento Equivalente a factura de venta eliminado existosamente"
    redirect_to business_invoice_equivalents_path(@business)
  end

  def print
    authorize @invoice_equivalent
    @contact = @invoice_equivalent.contact
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: @invoice_equivalent.pdf_file_name, layout: 'pdf.html', show_as_html: params.key?('debug')   # Excluding ".pdf" extension.
      end
    end
  end

  def toggle_printed
    @invoice_equivalent.update(printed: !@invoice_equivalent.printed)
  end

  private

  def invoice_equivalent_params
    strong_params = params.require(:invoice_equivalent).permit(
                      :business_id,
                      :contact_id,
                      :date,
                      :number,
                      :observation,
                      :retention_type,
                      :description,
                      :amount,
                      :retention,
                      attachments_attributes: [:id, :file, "@original_filename", "@content_type", "@headers", "_destroy"]
                    )
    # strong_params[:amount] = strong_params[:amount].gsub(",", "") if strong_params[:amount]
    strong_params[:attachments_attributes].each { |attachment| attachment[:name] = attachment[:file].original_filename } if strong_params[:attachments_attributes].is_a?(Array)
    strong_params
  end

  def set_invoice_equivalent
    @invoice_equivalent = InvoiceEquivalent.includes(:contact).find(params[:id])
  end
end
