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
      create_bill(owner_params(owner))
    end
  end

  private

  def create_bill(owner_params)
    @owner = Owner.find(owner_params[:owner_id])
    @owner.shares.each do |share|
      next if share.payment_percentage.zero?
      Bill.create(share: share, status: "Pendiente")
    end
  end

  def owner_params(params)
    params.permit(:enviar, :owner_id)
  end
end
