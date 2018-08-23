require 'rails_helper'

RSpec.describe Property, type: :model do
  it "is valid with attributes" do
    property = FactoryBot.build(:property)
    expect(property).to be_valid
  end

  it "is invalid without a property_type" do
    property = FactoryBot.build(:property, property_type: nil)
    expect(property).to_not be_valid
    expect(property.errors.messages).to have_key(:property_type)
  end

  it "is invalid without a name" do
    property = FactoryBot.build(:property, name: nil)
    expect(property).to_not be_valid
    expect(property.errors.messages).to have_key(:name)
  end

  it "is invalid without a building_coeficient" do
    property = FactoryBot.build(:property, building_coeficient: nil)
    expect(property).to_not be_valid
    expect(property.errors.messages).to have_key(:building_coeficient)
  end

  it "is invalid with a building_coeficient greater_than 1" do
    property = FactoryBot.build(:property, building_coeficient: 1.1)
    expect(property).to_not be_valid
    expect(property.errors.messages).to have_key(:building_coeficient)
  end

  it "is invalid with a building_coeficient equal to 0" do
    property = FactoryBot.build(:property, building_coeficient: 0)
    expect(property).to_not be_valid
    expect(property.errors.messages).to have_key(:building_coeficient)
  end

  it "is valid with a building_coeficient between to 0 and 1" do
    property = FactoryBot.build(:property, building_coeficient: 0.8)
    expect(property).to be_valid
  end

  it "is invalid without a building" do
    property = FactoryBot.build(:property, building: nil)
    expect(property).to_not be_valid
    expect(property.errors.messages).to have_key(:building)
  end

  context "shares relationship" do
    it "can have many shares" do
      property = FactoryBot.create(:property, :fifty_fifty)
      expect(property.shares.size).to eq 2
    end
  end

  context "owners relationship" do
    it "can have many owners" do
      property = FactoryBot.create(:property, :fifty_fifty)
      expect(property.owners.size).to eq 2
    end

    it "can have many owners without shares" do
      owner = FactoryBot.create(:owner)
      property = FactoryBot.create(:property)
      property.owners << owner
      expect(property.owners.size).to eq 1
    end
  end
end
