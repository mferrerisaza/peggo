require 'rails_helper'

RSpec.describe Property, type: :model do
  it "is valid with attributes" do
    property = FactoryBot.build(:property)
    expect(property).to be_valid
  end
end
