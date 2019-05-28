class ExpensesController < ApplicationController
  before_action :set_building, except: :update

  def index
    @expenses = policy_scope(Expense.where(building: @building).order(created_at: :asc))
  end
end
