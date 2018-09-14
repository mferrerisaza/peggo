module LoginSupport
  def sign_in_as(user)
    visit root_path
    within ".banner-content" do
      click_link "Iniciar Sesión"
    end
    fill_in "Email", with: user.email
    fill_in "Contraseña", with: user.password
    click_button "Iniciar Sesión"
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
