require "application_system_test_case"

class InvoiceEquivalentsTest < ApplicationSystemTestCase
  setup do
    login_as users(:mike)
    @business = businesses(:xloop)
    visit "/"
    find(".card").click
    within "#mySidenav" do
      click_on "Documentos Equivalentes"
    end
  end

  test "let a signed in user create an invoice equivalent within a business" do
    find(".mdc-fab.fab-bottom-right.fab-color").click
    fill_in "Descripción", with: "Prestación Servicios De Desarrollo Web"
    find(".datepicker-expense").click
    assert_selector ".flatpickr-calendar"
    within ".flatpickr-calendar" do
      find(".flatpickr-day.today").click
    end
    fill_in "Valor de la operación", with: ""
    fill_in "Valor de la operación", with: 600_000
    total_input = find(".invoice_equivalent_total input")
    retention_input = find(".invoice_equivalent_retention input")

    assert_equal "600,000", total_input.value
    assert_equal "0.00", retention_input.value

    within ".invoice_equivalent_contact" do
      find(".ss-arrow").click
      assert_selector ".ss-option:not(.ss-disabled)", count: Contact.where(business: @business).where(provider: true).size
      find(
        ".ss-option:not(.ss-disabled)",
        match: :prefer_exact,
        text: contacts(:provider).name,
      ).click
    end

    within ".invoice_equivalent_retention_type" do
      find(".ss-arrow").click
      assert_selector ".ss-option:not(.ss-disabled)", count: InvoiceEquivalent.retention_types.keys.size
      find(
        ".ss-option:not(.ss-disabled)",
        match: :prefer_exact,
        text: "Servicios en general - (4%)"
      ).click
    end
    assert_equal "576,000", total_input.value
    assert_equal "24,000", retention_input.value
    assert_difference 'InvoiceEquivalent.count' do
      click_on "Crear"
    end
  end

  test "let a signed in user edit an expense" do
    setup


    assert_selector ".table-row-link", count: InvoiceEquivalent.count

    invoice_equivalent = invoice_equivalents(:prestacion_servicios_mercadeo)

    within "[data-table-row-location='#{business_invoice_equivalent_path(@business, invoice_equivalent)}']" do
      find(".edit-property").click
    end

    total_input = find(".invoice_equivalent_total input")
    retention_input = find(".invoice_equivalent_retention input")

    assert_equal "576,000.00", total_input.value
    assert_equal "24,000.00", retention_input.value

    fill_in "Descripción", with: "Prestación Servicios Editado"
    fill_in "Valor de la operación", with: ""
    fill_in "Valor de la operación", with: 1_000_000
    fill_in "Retención en la fuente", with: ""
    fill_in "Retención en la fuente", with: 100_000
    assert_equal "900,000", total_input.value
    assert_equal "100,000", retention_input.value
    within ".invoice_equivalent_retention_type" do
      find(".ss-arrow").click
      assert_selector ".ss-option:not(.ss-disabled)", count: InvoiceEquivalent.retention_types.keys.size
      find(".ss-option", match: :first).click
    end

    click_on "Editar"

    invoice_equivalent.reload

    assert_equal invoice_equivalent.total, 900_000.to_money
    assert_equal "Prestación Servicios Editado", invoice_equivalent.description

  end

  test "let a signed in user delete an invoice equivalent" do
    invoice_equivalent_count = InvoiceEquivalent.count

    accept_alert do
      find(".destroy-property", match: :first).click
    end

    assert_selector ".alert.alert-info.alert-dismissible"
    assert_equal invoice_equivalent_count - 1, InvoiceEquivalent.count
  end
end
