class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :set_building, only: [:support]

  def home
  end

  def support
  end
end
