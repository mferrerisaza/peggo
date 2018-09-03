class BillsController < ApplicationController
  before_action :set_building, only: %i[show new create]

  def index
  end

  def new
    @properties = @building.building_properties
    @bill = Bill.new
    authorize @bill
    @bills_array = [@bill]
  end

  def create
    @properties = @building.building_properties
    params[:bill].each do |b|
      if b[:enviar].present?
        @bill = Bill.new(bill_params(b))
        authorize @bill
        @bill.save
      end
    end
    render :new
  end

  private

  def bill_params(params)
    params.permit(:status, :share_id)
  end

  def set_building
    @building = Building.find(params[:building_id])
  end


end
