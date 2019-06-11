class ContactsController < ApplicationController
  before_action :set_business
  before_action :set_contact, only: %i[show edit update destroy]

  def index
    @contacts = policy_scope(Contact.where(business: @business).order(created_at: :asc))
  end

  def show
    authorize @contact
  end

  def new
    @contact = Contact.new
    authorize @business, :business_of_current_user?
  end

  def create
    @contact = Contact.new(contact_params)
    authorize @business, :business_of_current_user?
    if @contact.save
      flash[:notice] = "Contacto creado existosamente"
      redirect_to business_contact_path @business, @contact
    else
      render :new
    end
  end

  def edit
    authorize @business, :business_of_current_user?
  end

  def update
    authorize @business, :business_of_current_user?
    if @contact.update(contact_params)
      flash[:notice] = "Contacto actualizado existosamente"
      redirect_to business_contact_path @business, @contact
    else
      render 'edit'
    end
  end

  def destroy
    authorize @contact
    @contact.destroy
    flash[:notice] = "Contact eliminado existosamente"
    redirect_to business_contacts_path(@business)
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(
      :name,
      :tax_id_type,
      :tax_id,
      :phone,
      :cell_phone,
      :email,
      :province,
      :city,
      :address,
      :client,
      :provider,
      :business_id
    )
  end
end
