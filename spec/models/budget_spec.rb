require 'rails_helper'

RSpec.describe Budget, type: :model do
  it "is valid with a start_date, end_date, amount and building" do
    budget = FactoryBot.build(:budget)
    expect(budget).to be_valid
  end

  it "monetize the budget amount with money rails" do
    budget = FactoryBot.build(:budget)
    expect(budget).to monetize(:amount).with_currency(:cop)
  end

  it "is invalid without start_date" do
    budget = FactoryBot.build(:budget, start_date: nil)
    expect(budget).to_not be_valid
    expect(budget.errors.messages).to have_key(:start_date)
  end

  it "is invalid without end_date" do
    budget = FactoryBot.build(:budget, end_date: nil)
    expect(budget).to_not be_valid
    expect(budget.errors.messages).to have_key(:end_date)
  end

  it "is invalid without a building" do
    budget = FactoryBot.build(:budget, building: nil)
    expect(budget).to_not be_valid
    expect(budget.errors.messages).to have_key(:building)
  end

  it "is invalid with amount 0" do
    budget = FactoryBot.build(:budget, amount: 0)
    expect(budget).to_not be_valid
    expect(budget.errors.messages).to have_key(:amount)
  end

  it "is invalid with a start_date > end_date" do
    budget = FactoryBot.build(:budget, start_date: "2018-01-02", end_date: "2018-01-01")
    expect(budget).to_not be_valid
    expect(budget.errors.messages).to have_key(:end_date)
  end

  it "is valid with a start_date = end_date" do
    budget = FactoryBot.build(:budget, start_date: "2018-01-01", end_date: "2018-01-01")
    expect(budget).to be_valid
  end

  context "expenses relationship" do
    it "can have many expenses" do
      budget = FactoryBot.create(:budget, :with_expenses)
      expect(budget.expenses.size).to eq 10
    end
  end
end
