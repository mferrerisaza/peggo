class BusinessesController < ApplicationController
  before_action :set_business, only: %w[show edit update destroy]

  def index
    @businesses = policy_scope(Business)
  end

  def show
    authorize @business
  end

  def new
    @business = Business.new
    authorize @business
  end

  def create
    @business = Business.new(business_params)
    authorize @business
    if @business.save
      redirect_to business_path(@business)
    else
      render 'new'
    end
  end

  def edit
    authorize @business
  end

  def update
    authorize @business
    if @business.update(business_params)
      redirect_to businesses_path
    Business
      render 'new'
    end
  end

  def destroy
    authorize @business
    @business.destroy
    flash[:notice] = "Empresa eliminada existosamente"
    redirect_to businesses_path
  end

  private

  def business_params
    params.require(:business).permit(:name, :user_id, :address, :email, :tax_id, :cell_phone, :logo, :logo_cache)
  end
end
