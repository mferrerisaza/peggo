class ItemsController < ApplicationController
  before_action :set_business

  def index
    authorize @business, :business_of_current_user?

    @items = policy_scope(Item.where(business: @business))
    render json: @items
  end
end
