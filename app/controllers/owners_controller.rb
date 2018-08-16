class OwnersController < ApplicationController

  def new
    @owner = Owner.new
    # authorize @owner
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      redirect_to owners_path
    else
      render :new
    end
  end

  def index
    @owners = Owner.all
  end

  def show
  end

  private

  def owner_params
    params.require(:owner).permit(:name, :card_number, :phone, :email)
  end
end
