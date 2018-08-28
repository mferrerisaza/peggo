require 'rails_helper'

RSpec.feature "Shares features", type: :feature do
  scenario "user creates a share on property show", js: true do
    user = FactoryBot.create(:user, :with_owners)
    building = FactoryBot.create(:building, :with_propierties)
    owner = user.owners.first
    property = building.properties.first
    user.buildings << building

    sign_in_as user

    click_link building.name
    # Acomodar el size de la pantalla para que no se oculte el sidebar
    page.driver.browser.manage.window.resize_to(1024, 768)
    click_link "Propiedades"
    find("tr[data-id='#{property.id}']").click
    aggregate_failures do
      expect(page).to have_content(property.full_name)
      expect(page).to have_content("Agregar propertario")
      expect(page).to_not have_css("#new_share")
    end
    click_link "Agregar propertario"
    expect(page).to have_css('#new_share')
    expect do
      select owner.name, from: "share_owner_id"
      fill_in "share_ownerability_percentage", with: "0.1"
      fill_in "share_payment_percentage", with: "1"
      within "#new_share" do
        find(".submit-share-form").click
      end
      expect(page).to have_content(owner.name)
      expect(page).to_not have_css("#new_share")
      expect(page).to have_content("Agregar propertario")
    end.to change(property.shares, :count).by 1
  end

  scenario "user updates a share on property show", js: true do
    user = FactoryBot.create(:user, :with_owners)
    building = FactoryBot.create(:building)
    owner = user.owners.first
    property = FactoryBot.create(:property, :fifty_fifty)
    share = property.shares.first
    original_owner = share.owner
    building.properties << property
    user.buildings << building

    sign_in_as user

    click_link building.name
    # Acomodar el size de la pantalla para que no se oculte el sidebar
    page.driver.browser.manage.window.resize_to(1024, 768)
    click_link "Propiedades"
    find("tr[data-id='#{property.id}']").click
    within "div[data-share-id='#{share.id}']" do
      find(".edit-share-info").click
    end
    expect(page).to have_css("#edit_share_#{share.id}")
    expect do
      select owner.name, from: "share_owner_id"
      within "#edit_share_#{share.id}" do
        find(".submit-share-form").click
      end
      expect(page).to have_content(owner.name)
      expect(page).to_not have_css("#edit_share_#{share.id}")
      share.reload
    end.to change(share, :owner_id).from(original_owner.id).to(owner.id)
  end

  scenario "user deletes a share on property show", js: true do
    user = FactoryBot.create(:user, :with_owners)
    building = FactoryBot.create(:building)
    property = FactoryBot.create(:property, :fifty_fifty)
    share = property.shares.first
    building.properties << property
    user.buildings << building

    sign_in_as user

    click_link building.name
    # Acomodar el size de la pantalla para que no se oculte el sidebar
    page.driver.browser.manage.window.resize_to(1024, 768)
    click_link "Propiedades"
    find("tr[data-id='#{property.id}']").click
    within "div[data-share-id='#{share.id}']" do
      find(".delete-share").click
    end
    expect do
      expect(page.driver.browser.switch_to.alert.text).to eq "¿Estás seguro?"
      page.driver.browser.switch_to.alert.accept
      save_and_open_screenshot
      expect(page).to_not have_css("div[data-share-id='#{share.id}']")
      expect(page).to_not have_content(share.owner.name)
    end.to change(property.shares, :count).by(-1)
  end
end
