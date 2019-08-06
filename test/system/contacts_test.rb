require "application_system_test_case"

class ContactsTest < ApplicationSystemTestCase
  def setup
    login_as users(:mike)
    @business = businesses(:xloop)
    visit "/"
    find(".card").click
    within "#mySidenav" do
      click_on "Contactos"
    end
  end

  test "let a signed in user create a contact within a business" do
    setup

    find(".mdc-fab.fab-bottom-right.fab-color").click

    fill_in "Nombre", with: "Miguel Ferrer"
    select "NIT - Número de identificación tributaria", from: "Tipo de Identificación"
    fill_in "Número de Identificación", with: "1040182869"

    assert_difference 'Contact.count' do
      click_on "Crear"
    end
    assert_selector ".alert.alert-info.alert-dismissible"
  end

  test "let a signed in user edit a contact" do
    setup


    assert_selector ".table-row-link", count: Contact.count

    contact = contacts(:amg)

    within "[data-table-row-location='#{business_contact_path(@business, contact)}']" do
      find(".edit-property").click
    end
    fill_in "Nombre", with: "Scuad S.A.S Editado"
    check "Agregar como Cliente"

    click_on "Editar"

    contact.reload

    assert_equal "Scuad S.A.S Editado", contact.name
    assert contact.client
  end

  test "let a signed in user delete a contact" do
    setup

    contact_count = Contact.count

    accept_alert do
      find(".destroy-property", match: :first).click
    end

    assert_selector ".alert.alert-info.alert-dismissible"
    assert_equal contact_count - 1, Contact.count
  end
end
