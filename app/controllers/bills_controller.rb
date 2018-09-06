class BillsController < ApplicationController
  before_action :set_building, only: %i[show new create]

  def index
  end

  def new
    @properties = @building.properties
    @bill = Bill.new
    authorize @bill
    @bills_array = [@bill]
  end

  def create
    @properties = @building.properties
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
end
