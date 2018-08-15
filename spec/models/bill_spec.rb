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
      bill = FactoryBot.create(:bill, :with_concepts)
      expect(bill.concepts.size).to eq 5
    end
  end
end
