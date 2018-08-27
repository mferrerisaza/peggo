class SharesController < ApplicationController
  before_action :set_share, only: :destroy

  def create
    @share = Share.new(share_params)
    @property = Property.find(share_params[:property_id]) if share_params[:property_id].present?
    @owner = Owner.find(share_params[:owner_id]) if share_params[:owner_id].present?
    @building = @property.building
    authorize @share
    if @share.save
      respond_to do |format|
        format.html {  redirect_back(fallback_location: root_path) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render template: "properties/show" }
        format.js
      end
    end
  end

  def destroy
    authorize @share
    @share.destroy
  end

  private

  def set_share
    @share = Share.find(params[:id])
  end

  def share_params
    params.require(:share).permit(
      :owner_id,
      :property_id,
      :payment_percentage,
      :ownerability_percentage
    )
  end
end
