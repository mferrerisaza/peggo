class ConceptsController < ApplicationController
  before_action :set_building, only: %w[edit update]
  before_action :set_bill, only: %w[edit update]
  before_action :set_concept, only: %w[edit update]

  def edit
    authorize @concept
  end

  def update
    @building = Building.find(params[:building_id])
    authorize @building, :building_of_current_user?
    if @concept.update(amount_paid_cents: (@concept.amount_paid_cents + concept_params[:amount_paid_cents].to_i))
      flash[:notice] = "Pago registrado existosamente"
      if @bill.bill_debt.zero?
        @bill.status == "Pagada"
      end
      redirect_to building_bills_path(@building, @bill)
    else
      render 'edit'
    end
  end

  private

  def concept_params
    params.require(:concept).permit(:amount_paid_cents)
  end

  def set_concept
    @concept = Concept.find(params[:id])
  end

  def set_bill
    @bill = Bill.find(params[:bill_id])
  end
end
