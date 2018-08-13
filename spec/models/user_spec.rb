require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with email and password" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is invalid without email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without password" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid with duplicate email address" do
    FactoryBot.create(:user, email: "miguef7@gmail.com")
    user = FactoryBot.build(:user, email: "miguef7@gmail.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
end
