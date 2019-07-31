class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def export
    @business = Business.find(params[:id])
  end
end
