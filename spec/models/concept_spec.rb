require 'rails_helper'

RSpec.describe Concept, type: :model do
  before do
    building = FactoryBot.create(:building, :with_active_budget)
    owner = FactoryBot.create(:owner, building: building)
    share = FactoryBot.create(:share, owner: owner)
    @bill = FactoryBot.create(:bill, share: share)
    @other_bill = FactoryBot.create(:bill, share: share)
  end

  it "is valid with a bill, a description and an amount" do
    concept = FactoryBot.build(:concept, bill: @bill)
    expect(concept).to be_valid
  end

  it "is invalid without a bill" do
    concept = FactoryBot.build(:concept, bill: nil)
    expect(concept).to_not be_valid
    expect(concept.errors.messages).to have_key(:bill)
  end

  it "is invalid without a description" do
    concept = FactoryBot.build(:concept, description: nil, bill: @bill)
    expect(concept).to_not be_valid
    expect(concept.errors.messages).to have_key(:description)
  end

  it "is invalid with a duplicate description within the same bill" do
    FactoryBot.create(:concept, description: "Cuota Admin", bill: @bill)
    other_concept = FactoryBot.build(:concept, description: "Cuota Admin", bill: @bill)
    expect(other_concept).to_not be_valid
    expect(other_concept.errors.messages).to have_key(:description)
  end

  it "is valid with a duplicate description in different bills" do
    FactoryBot.create(:concept, description: "Cuota Admin", bill: @bill)
    other_concept = FactoryBot.build(:concept, description: "Cuota Admin", bill: @other_bill)
    expect(other_concept).to be_valid
  end

  it "monetize the amount with money rails" do
    concept = FactoryBot.build(:concept, bill: @bill)
    expect(concept).to monetize(:amount).with_currency(:cop)
  end
end
