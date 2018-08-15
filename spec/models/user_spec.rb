require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with email and password" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is invalid without email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user).to_not be_valid
    expect(user.errors.messages).to have_key(:email)
  end

  it "is invalid without password" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user).to_not be_valid
    expect(user.errors.messages).to have_key(:password)
  end

  it "is invalid with duplicate email address" do
    FactoryBot.create(:user, email: "miguef7@gmail.com")
    user = FactoryBot.build(:user, email: "miguef7@gmail.com")
    user.valid?
    expect(user).to_not be_valid
    expect(user.errors.messages).to have_key(:email)
  end

  it "can manage many buildings" do
    user = FactoryBot.create(:user, :with_buildings)
    expect(user.buildings.size).to eq 2
  end
end
