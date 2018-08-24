require 'rails_helper'

RSpec.feature "Properties features", type: :feature do
  scenario "user creates a property", js: true do
    user = FactoryBot.create(:user, :with_buildings)
    building = user.buildings.first

    visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link building.name
    # Acomodar el size de la pantalla para que no se oculte el sidebar
    page.driver.browser.manage.window.resize_to(1024, 768)
    click_link "Propiedades"

    expect do
      find(".mdc-fab").click
      select "Apartamento", from: "Tipo de propiedad"
      fill_in "Número de la propiedad", with: "Apartamento 1"
      fill_in "Teléfono de la propiedad", with: "2660480"
      fill_in "Dirección de la propiedad", with: "Calle 11a # 42 -18 Int 1"
      fill_in "Número de matricula inmobiliaria", with: "505699"
      fill_in "Área de la propiedad en mt2", with: 53
      fill_in "Coeficiente de copropiedad", with: 0.1
      click_button "Crear"
      expect(page).to have_content "Propiedad creada existosamente"
      expect(page).to have_content "Apartamento 1"
    end.to change(building.properties, :count).by 1
  end

  scenario "user edit a property", js: true do
    user = FactoryBot.create(:user)
    building = FactoryBot.create(:building, :with_propierties)
    property = building.properties.first
    property_name = building.properties.first.name
    user.buildings << building

    visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link building.name
    # Acomodar el size de la pantalla para que no se oculte el sidebar
    page.driver.browser.manage.window.resize_to(1024, 768)
    click_link "Propiedades"
    within find("tr[data-id='#{property.id}']") do
      find(".edit-property").click
    end
    expect do
      select "Casa", from: "Tipo de propiedad"
      fill_in "Número de la propiedad", with: "Casa 1"
      click_button "Editar"
      expect(page).to have_content "Propiedad editada existosamente"
      expect(find("tr[data-id='#{property.id}']")).to have_content "Casa 1"
      property.reload
    end.to change(property, :name).from(property_name).to("Casa 1")
  end

  scenario "user visit show of a property", js: true do
    user = FactoryBot.create(:user)
    building = FactoryBot.create(:building, :with_propierties)
    property = building.properties.first
    user.buildings << building

    visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link building.name
    # Acomodar el size de la pantalla para que no se oculte el sidebar
    page.driver.browser.manage.window.resize_to(1024, 768)
    click_link "Propiedades"
    find("tr[data-id='#{property.id}']").click
    expect(page).to have_content(property.name)
  end

  scenario "user deletes a property", js: true do
    user = FactoryBot.create(:user)
    building = FactoryBot.create(:building, :with_propierties)
    property = building.properties.first
    user.buildings << building

    visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link building.name
    # Acomodar el size de la pantalla para que no se oculte el sidebar
    page.driver.browser.manage.window.resize_to(1024, 768)
    click_link "Propiedades"
    within find("tr[data-id='#{property.id}']") do
      find(".destroy-property").click
    end
    expect do
      expect(page.driver.browser.switch_to.alert.text).to eq "¿Estás seguro?"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content "Propiedad eliminada con éxito"
    end.to change(building.properties, :count).by(-1)
  end

  scenario "edit a property building with other users building", js: true do
    user = FactoryBot.create(:user)
    building = FactoryBot.create(:building, :with_propierties)
    property = building.properties.first
    user.buildings << building

    other_user = FactoryBot.create(:user, :with_buildings)
    other_building = other_user.buildings.first

    visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link building.name
    # Acomodar el size de la pantalla para que no se oculte el sidebar
    page.driver.browser.manage.window.resize_to(1024, 768)
    click_link "Propiedades"
    within find("tr[data-id='#{property.id}']") do
      find(".edit-property").click
    end
    expect do
      page.execute_script("document.getElementById('property_building_id').value = '#{other_building.id}'")
      click_button "Editar"
      expect(page).to have_content "You are not authorized to perform this action."
      property.reload
    end.to_not change(building.properties, :count)
  end
end
