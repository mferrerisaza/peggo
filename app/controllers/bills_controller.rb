class BillsController < ApplicationController
  before_action :set_building, only: %i[index show new create]

  def index
  end

  def new
    @properties = @building.building_properties
    @bill = Bill.new
    authorize @bill
    @bills_array = [@bill]
  end

  def create
    raise
    @bill = Building.new(bill_params)
    authorize @bill
    if @bill.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:name, :user_id)
  end

  def set_building
    @building = Building.find(params[:building_id])
  end
end
