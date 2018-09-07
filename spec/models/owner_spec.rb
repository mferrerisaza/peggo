require 'rails_helper'

RSpec.describe Owner, type: :model do
  it "is valid with name, card_number, phone, email and user" do
    owner = FactoryBot.build(:owner)
    expect(owner).to be_valid
  end

  it "returns shares bill_payment sum" do
    building = FactoryBot.create(:building, :with_active_budget)
    owner = FactoryBot.create(:owner, :with_shares, building: building)
    expect(owner.bill_amount).to eq building.active_budget.amount / 12 * 0.1 * 2
  end

  it "is invalid without name" do
    owner = FactoryBot.build(:owner, name: nil)
    expect(owner).to_not be_valid
    expect(owner.errors.messages).to have_key(:name)
  end

  it "is invalid without email" do
    owner = FactoryBot.build(:owner, email: nil)
    expect(owner).to_not be_valid
    expect(owner.errors.messages).to have_key(:email)
  end

  it "is invalid without user" do
    owner = FactoryBot.build(:owner, user: nil)
    expect(owner).to_not be_valid
    expect(owner.errors.messages).to have_key(:user)
  end

  context 'shares relationship' do
    it "can have many shares" do
      owner = FactoryBot.create(:owner, :with_shares)
      expect(owner.shares.size).to eq 2
    end
  end

  context 'properties relationship' do
    it "can have many properties" do
      owner = FactoryBot.create(:owner, :with_shares)
      expect(owner.properties.size).to eq 2
    end
  end

  it "is invalid without card_number" do
    owner = FactoryBot.build(:owner, card_number: nil)
    expect(owner).to_not be_valid
    expect(owner.errors.messages).to have_key(:card_number)
  end

  it "has a unique card_number" do
    older_owner = FactoryBot.create(:owner)
    owner = FactoryBot.build(:owner, card_number: older_owner.card_number)
    expect(owner).to_not be_valid
  end
end
