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

  it "is invalid without card_number" do
    owner = FactoryBot.build(:owner, card_number: nil)
    expect(owner).to_not be_valid
    expect(owner.errors.messages).to have_key(:card_number)
  end

  it "has a unique card_number" do
    older_owner = FactoryBot.create(:owner)
    owner = FactoryBot.build(:owner, card_number: older_owner.card_number)
    expect(owner).to_not be_valid
  end
end

RSpec.describe "adding an owner", type: :system do
  it  "allows a user to create an owner" do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    visit new_owner_path
    fill_in "Nombre del propietario", with: "Daniel José López"
    fill_in "Cédula del propietario", with: "1040182859"
    fill_in "Teléfono del propietario", with: "2660480"
    fill_in "Correo electrónico del propietario", with: "daniel@gmail.com"
    click_on("Crear Propietario")
    visit owners_path
    expect(page).to have_content("Daniel José López")
  end
end


  def new
    @owner = Owner.new
  end

  def create
  end

  def index
  end

  def show
  end
