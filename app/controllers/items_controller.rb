class ItemsController < ApplicationController
  before_action :set_business

  def create
    @item = Item.new(item_params)
    authorize @business, :business_of_current_user?
    if @item.save
      respond_to do |format|
        format.html { redirect_to business_invoice_path(@building, @item.invoice) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'invoices/new' }
        format.js
      end
    end
  end

  def update
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :quantity, :price, :vat, :discount, :invoice_id)
  end
end
