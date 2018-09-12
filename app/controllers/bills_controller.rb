class BillsController < ApplicationController
  before_action :set_building, only: %i[new create]

  def new
    authorize @building, :building_of_current_user?
    @owners = @building.owners
  end

  def create
    authorize @building, :building_of_current_user?
    params[:bills].each do |owner|
      next unless owner[:enviar].present?
      create_bill(owner_params(owner), bill_params(params))
    end
    redirect_to building_path(@building)
  end

  private

  def owner_params(params)
    params.permit(:enviar, :owner_id)
  end

  def bill_params(params)
    params.permit(:bill_period)[:bill_period]
  end

  def create_bill(owner_params, bill_period)
    @owner = Owner.find(owner_params[:owner_id])
    @owner.shares.each do |share|
      next if share.payment_percentage.zero?
      Bill.create(share: share, status: "Pendiente", period: bill_period)
    end
  end
end
