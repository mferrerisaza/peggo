require 'rails_helper'

RSpec.describe Bill, type: :model do
  it "is valid with a share and a status" do
    bill = FactoryBot.build(:bill)
    expect(bill).to be_valid
  end

  it "is invalid without a share" do
    bill = FactoryBot.build(:bill, share: nil)
    expect(bill).to_not be_valid
    expect(bill.errors.messages).to have_key(:share)
  end

  it "is invalid without a status" do
    bill = FactoryBot.build(:bill, status: nil)
    expect(bill).to_not be_valid
    expect(bill.errors.messages).to have_key(:status)
  end

  context "concepts relationship" do
    it "can have many concepts" do
      building = FactoryBot.create(:building, :with_active_budget)
      owner = FactoryBot.create(:owner, building: building)
      share = FactoryBot.create(:share, owner: owner)
      bill = FactoryBot.create(:bill, share: share)
      expect(bill.concepts.size).to eq 1
    end
  end
end
