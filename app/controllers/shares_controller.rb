class SharesController < ApplicationController
  before_action :set_share, only: :destroy
  before_action :set_property_owner_and_building, only: :create

  def create
    @share = Share.new(share_params)
    authorize @share
    if @share.save
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render template: "#{params[:render][:name]}/show" }
        format.js
      end
    end
  end

  def destroy
    authorize @share
    @share.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_share
    @share = Share.find(params[:id])
  end

  def set_property_owner_and_building
    @property = Property.find(share_params[:property_id]) if share_params[:property_id].present?
    @owner = Owner.find(share_params[:owner_id]) if share_params[:owner_id].present?
    @building = @property.building
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
