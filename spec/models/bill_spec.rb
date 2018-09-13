require 'rails_helper'

RSpec.describe Bill, type: :model do
  it "is valid with a share, a status and a period" do
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


  it "is invalid without a period" do
    bill = FactoryBot.build(:bill, period: nil)
    expect(bill).to_not be_valid
    expect(bill.errors.messages).to have_key(:period)
  end

  it "is invalid without the proper period format" do
    bill = FactoryBot.build(:bill, period: "Some string")
    expect(bill).to_not be_valid
    expect(bill.errors.messages). to have_key(:period)
  end

  it "is valid with the proper period format" do
    bill = FactoryBot.build(:bill, period: "2018/01")
    expect(bill).to be_valid
  end

  it "returns 0 if payment_percentage is zero" do
    @building = FactoryBot.create(:building, :with_active_budget, :with_propierties)
    @owner = FactoryBot.create(:owner, building: @building)
    @share = FactoryBot.create(:share, :with_bills, owner: @owner, payment_percentage: 0)
    expect(@owner.owner_debt).to eq 0
  end

  context "bills math" do
    before do
      @building = FactoryBot.create(:building, :with_active_budget, :with_propierties)
      @owner = FactoryBot.create(:owner, building: @building)
      @share = FactoryBot.create(:share, owner: @owner)
      @property = FactoryBot.create(:property, building: @building)
      @bill = FactoryBot.create(:bill, share: @share)
      @bill_paid = FactoryBot.create(:bill, share: @share)
      @bill_paid.update(status: "Pagada")
    end

    it "returns the correct sum of amounts bill concepts" do
      expect(@bill.sum_concepts_amount).to eq 10000000/12
    end

    it "returns the correct number of unpaid bills" do
      expect(@share.unpaid_bills.size).to eq 1
    end

    it "return the correct amount of debt for a share" do
      expect(@owner.owner_debt).to eq 10000000/12
    end

    it "return the correct amount of debt for and owner" do
      expect(@owner.owner_debt).to eq 10000000/12
    end

    it "returns 0 if all bills are paid" do
      @share = FactoryBot.create(:share, :with_bills, property: @property, owner: @owner, payment_percentage: 0)
      @share.bills.each do |bill|
        bill.status = "Pagada"
      end
      expect(@share.bills_debt).to eq 0
    end
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
