require "application_system_test_case"

class BusinessesTest < ApplicationSystemTestCase
  test "let a signed in user create a new business" do
    login_as users(:mike)
    visit "/"

    find('.add-new-button').click
    fill_in "Nombre de la empresa", with: "Scuad Pruebas"
    assert_difference 'Business.count' do
      click_on "Crear"
    end
  end
end
