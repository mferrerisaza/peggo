require "application_system_test_case"

class BusinessesTest < ApplicationSystemTestCase
  setup do
    login_as users(:mike)
    @business = businesses(:xloop)
    @businesses_count = Business.count
    visit "/"
  end

  test "let a signed in user create a new business" do
    find('.add-new-button').click
    fill_in "Nombre de la empresa", with: "Scuad Pruebas"
    assert_difference 'Business.count' do
      click_on "Crear"
    end
  end

  test "let a signed in user edit an existing business" do
    within ".card-actions" do
      find('.edit-business').click
    end

    fill_in "Nombre de la empresa", with: "Scuad Editado"
    page.attach_file("Logo", Rails.root + 'test/fixtures/files/SCUAD-final.png')

    click_on "Editar"
    sleep(10)
    @business.reload

    assert_equal "Scuad Editado", @business.name
    assert_not_nil @business.logo

    delete_attached_logo_from_cloudinary(@business)
  end

  test "let a signed in user delete existing business" do
    within ".card-actions" do
      accept_alert do
        find('.delete-business').click
      end
    end
    assert_selector ".alert.alert-info.alert-dismissible"
    assert_equal @businesses_count - 1, Business.count
  end


  private

  def delete_attached_logo_from_cloudinary(business)
    business.logo.file.delete
  end
end
