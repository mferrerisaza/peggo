require 'rails_helper'

RSpec.describe Owner, type: :model do
  it "is valid with name, card_number, phone, and email" do
    owner = FactoryBot.build(:owner)
    expect(owner).to be_valid
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
end
