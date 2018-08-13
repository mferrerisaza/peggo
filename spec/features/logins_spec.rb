require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  scenario "user logins succefully" do
    user = FactoryBot.create(:user)
    visit root_path
    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    expect(page).to have_content "Signed in successfully."
  end
end
