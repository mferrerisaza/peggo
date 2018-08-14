require 'rails_helper'

RSpec.describe Expense, type: :model do
  it "is valid with attributes" do
    expense = FactoryBot.build(:expense)
    expect(expense).to be_valid
  end

  it "monetize the amount with money rails" do
    expense = FactoryBot.build(:expense)
    expect(expense).to monetize(:amount).with_currency(:cop)
  end

  it "is invalid without a date" do
    expense = FactoryBot.build(:expense, date: nil)
    expect(expense).to_not be_valid
    expect(expense.errors.messages).to have_key(:date)
  end

  it "is invalid without a budget" do
    expense = FactoryBot.build(:expense, budget: nil)
    expect(expense).to_not be_valid
    expect(expense.errors.messages).to have_key(:budget)
  end

  it "is invalid without an amount = 0" do
    expense = FactoryBot.build(:expense, amount: 0)
    expect(expense).to_not be_valid
    expect(expense.errors.messages).to have_key(:amount)
  end

  it "is invalid without a description" do
    expense = FactoryBot.build(:expense, description: nil)
    expect(expense).to_not be_valid
    expect(expense.errors.messages).to have_key(:description)
  end
end
