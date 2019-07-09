require 'rails_helper'

RSpec.describe Business, type: :model do
  it "is valid with a name and a user" do
    business = FactoryBot.build(:business)
    expect(business).to be_valid
  end

  it "is invalid without a name" do
    business = FactoryBot.build(:business, name: nil)
    expect(business).to_not be_valid
    expect(business.errors.messages).to have_key(:name)
  end

  it "is invalid without a user" do
    business = FactoryBot.build(:business, user: nil)
    expect(business).to_not be_valid
    expect(business.errors.messages).to have_key(:user)
  end

  it "does not allow duplicate business names per user" do
    user = FactoryBot.create(:user)
    user.businesses.create(name: "El Recinto")
    new_business = user.businesses.build(name: "El Recinto")
    new_business.valid?
    expect(new_business).to_not be_valid
    expect(new_business.errors.messages).to have_key(:name)
  end

  it "allow two users to share a project name" do
    user = FactoryBot.create(:user)
    user.businesses.create(name: "El Recinto")
    other_user = FactoryBot.create(:user)
    other_business = other_user.businesses.create(name: "El Recinto")
    expect(other_business).to be_valid
  end
end
