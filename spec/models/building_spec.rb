require 'rails_helper'

RSpec.describe Building, type: :model do
  it "is valid with a name and a user" do
    building = FactoryBot.build(:building)
    expect(building).to be_valid
  end

  it "is invalid without a name" do
    building = FactoryBot.build(:building, name: nil)
    expect(building).to_not be_valid
    expect(building.errors.messages).to have_key(:name)
  end

  it "is invalid without a user" do
    building = FactoryBot.build(:building, user: nil)
    expect(building).to_not be_valid
    expect(building.errors.messages).to have_key(:user)
  end

  it "does not allow duplicate building names per user" do
    user = FactoryBot.create(:user)
    user.buildings.create(name: "El Recinto")
    new_building = user.buildings.build(name: "El Recinto")
    new_building.valid?
    expect(new_building).to_not be_valid
    expect(new_building.errors.messages).to have_key(:name)
  end

  it "allow two users to share a project name" do
    user = FactoryBot.create(:user)
    user.buildings.create(name: "El Recinto")
    other_user = FactoryBot.create(:user)
    other_building = other_user.buildings.create(name: "El Recinto")
    expect(other_building).to be_valid
  end

  it "can have many properties" do
    building = FactoryBot.create(:building, :with_propierties)
    expect(building.properties.size).to eq 10
  end

  context "sum of properties building_properties" do
    it "returns the corrert sum of propierties building_coeficient" do
      building = FactoryBot.create(:building, :with_propierties)
      expect(building.building_coeficients_sum).to eq 1
    end

    it "returns the corrert sum of propierties area" do
      building = FactoryBot.create(:building, :with_propierties)
      expect(building.area_sum).to eq 500
    end
  end

  context "budgets relationship" do
    it "can have many unactive budgets" do
      building = FactoryBot.create(:building, :with_budgets)
      expect(building.budgets.size).to eq 11
      expect(building.budgets.any?(&:status)).to eq false
    end

    it "can only one active budget" do
      building = FactoryBot.create(:building, :with_budgets)
      building.budgets << FactoryBot.create(:budget)
      expect(building.budgets.where(status: true).size).to eq 1
    end

    it "can not have more than one active budget" do
      building = FactoryBot.create(:building, :with_budgets)
      first_budget = FactoryBot.build(:budget)
      second_budget = FactoryBot.build(:budget)
      building.budgets << first_budget
      building.budgets << second_budget
      expect(building.budgets.where(status: true).size).to eq 1
      expect(building.budgets.find_by(status: true)).to eq first_budget
      expect(second_budget.errors.messages).to have_key(:building)
    end
  end
end
