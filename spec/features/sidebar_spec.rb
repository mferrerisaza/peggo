# require 'rails_helper'

# RSpec.feature "Sidebar big screen", type: :feature, js: true  do
#   scenario "Show sidebar on dashboard" do
#     user = FactoryBot.create(:user, :with_buildings)
#     building = user.buildings.first
#     visit building_path(building)
#     page.driver.browser.manage.window.resize_to(1024, 768)
#     expect(page).to have_css("#mySidenav")
#   end
# end
