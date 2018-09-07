require 'rails_helper'

RSpec.describe Share, type: :model do
  it "is valid with property, owner, ownerability_percentage and payment_percentage" do
    share = FactoryBot.build(:share)
    expect(share).to be_valid
  end

  it "is invalid without property" do
    share = FactoryBot.build(:share, property: nil)
    expect(share).to_not be_valid
    expect(share.errors.messages).to have_key(:property)
  end

  it "is invalid without owner" do
    share = FactoryBot.build(:share, owner: nil)
    expect(share).to_not be_valid
    expect(share.errors.messages).to have_key(:owner)
  end

  it "is invalid without ownerability_percentage" do
    share = FactoryBot.build(:share, ownerability_percentage: nil)
    expect(share).to_not be_valid
    expect(share.errors.messages).to have_key(:ownerability_percentage)
  end

  it "is invalid with ownerability_percentage = 0" do
    share = FactoryBot.build(:share, ownerability_percentage: 0)
    expect(share).to_not be_valid
    expect(share.errors.messages).to have_key(:ownerability_percentage)
  end

  it "is invalid with ownerability_percentage > 1" do
    share = FactoryBot.build(:share, ownerability_percentage: 1.1)
    expect(share).to_not be_valid
    expect(share.errors.messages).to have_key(:ownerability_percentage)
  end

  it "is invalid without payment_percentage" do
    share = FactoryBot.build(:share, payment_percentage: nil)
    expect(share).to_not be_valid
    expect(share.errors.messages).to have_key(:payment_percentage)
  end

  it "is valid with payment_percentage = 0" do
    share = FactoryBot.build(:share, payment_percentage: 0)
    expect(share).to be_valid
  end

  it "is invalid with payment_percentage > 1" do
    share = FactoryBot.build(:share, payment_percentage: 1.1)
    expect(share).to_not be_valid
    expect(share.errors.messages).to have_key(:payment_percentage)
  end

  it "is invalid with duplicated owner within the same property" do
    owner = FactoryBot.create(:owner)
    property = FactoryBot.create(:property)
    share = FactoryBot.create(:share, owner: owner, property: property)
    other_share = FactoryBot.build(:share, owner: owner, property: property)
    expect(other_share).to_not be_valid
    expect(other_share.errors.messages).to have_key(:owner)
  end

  it "is valid with same owner within the different properties" do
    owner = FactoryBot.create(:owner)
    property = FactoryBot.create(:property)
    other_property = FactoryBot.create(:property)
    share = FactoryBot.create(:share, owner: owner, property: property)
    other_share = FactoryBot.build(:share, owner: owner, property: other_property)
    expect(other_share).to be_valid
  end

  it "returns the monthly bill amount" do
    building = FactoryBot.create(:building, :with_active_budget)
    owner = FactoryBot.create(:owner, building: building)
    property = FactoryBot.create(:property, building: building)
    share = FactoryBot.create(:share, owner: owner, property: property)
    expect(share.bill_payment).to eq building.active_budget.amount / 12 * 0.1
  end

  context "bill relationship" do
    it "can have many bills" do
      share = FactoryBot.create(:share, :with_bills)
      expect(share.bills.size).to eq 5
    end
  end
end
