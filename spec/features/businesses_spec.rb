require 'rails_helper'

RSpec.feature "Businesses features", type: :feature do
  scenario "user creates a business" do
    user = FactoryBot.create(:user)
    sign_in_as user

    expect do
      click_link "Crea una nueva empresa"
      fill_in "Nombre de la empresa", with: "Empresa de prueba"
      click_button "Crear"
      expect(page).to have_content "Empresa de prueba"
    end.to change(user.businesses, :count).by(1)
  end

  scenario "redirects to back after rendering errors" do
    user = FactoryBot.create(:user)
    sign_in_as user
    click_link "Crea una nueva empresa"
    fill_in "Nombre de la empresa", with: ""
    click_button "Crear"
    expect(page).to have_content "Name no puede estar en blanco"
    click_link "cancelar"
    expect(page.current_path).to eq businesses_path
  end
end
