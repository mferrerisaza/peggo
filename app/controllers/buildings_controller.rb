class BuildingsController < ApplicationController
  def index
    @buildings = policy_scope(Building)
  end

  def show
  end

  def new
  end

  def create
  end
end
