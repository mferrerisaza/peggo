require "application_system_test_case"

class PaymentsTest < ApplicationSystemTestCase
  setup do
    login_as users(:mike)
    @business = businesses(:xloop)
    visit "/"
    find(".card").click
    within "#mySidenav" do
      click_on "Pagos"
    end
  end

  test "let a signed in user create a payment for an invoice" do
    find(".mdc-fab.fab-bottom-right.fab-color").click

    contact = contacts(:client)
    within ".payment_contact" do
        find(".ss-arrow").click
        sleep(1)
        assert_selector ".ss-option:not(.ss-disabled)", count: Contact.where(business: @business).where(client: true).size
        find(
          ".ss-option:not(.ss-disabled)",
          match: :prefer_exact,
          text: contact.name,
        ).click
    end
    assert_selector ".payment_invoice"
    within ".payment_invoice" do
      find(".ss-arrow").click
      pending_invoices = Invoice.where(business: @business).where(contact: contact).to_a.keep_if { |invoice| invoice.status == "Por Cobrar" }.size
      assert_selector ".ss-option:not(.ss-disabled)", count: pending_invoices
      find(
        ".ss-option:not(.ss-disabled)",
        match: :prefer_exact,
        text: "Factura de Venta 001"
      ).click
    end

    assert_selector ".table-container.show-table"

    within ".payment_retention_type" do
      find(".ss-arrow").click
      assert_selector ".ss-option:not(.ss-disabled)", count: Payment.retention_types.keys.size
      find(
        ".ss-option:not(.ss-disabled)",
        match: :prefer_exact,
        text: "Servicios en general - (4%)"
      ).click
    end

    retention_input = find(".payment_retention input")
    amount_input = find(".payment_amount input")
    description_input = find(".payment_description input")

    assert_equal "200,000", retention_input.value
    assert_equal "4,935,000", amount_input.value
    assert_equal "Pago Factura de Venta 001", description_input.value

    select "Transferencia", from: "Método de pago"
    find(".datepicker-expense").click

    assert_selector ".flatpickr-calendar"

    within ".flatpickr-calendar" do
      find(".flatpickr-day.today").click
    end

    assert_difference 'Payment.count' do
      click_on "Crear"
    end
  end

  test "let a signed in user create a payment not associated with invoice" do
    find(".mdc-fab.fab-bottom-right.fab-color").click

    contact = contacts(:client_with_out_bills)

    within ".payment_contact" do
        find(".ss-arrow").click
        sleep(1)
        assert_selector ".ss-option:not(.ss-disabled)", count: Contact.where(business: @business).where(client: true).size
        find(
          ".ss-option:not(.ss-disabled)",
          match: :prefer_exact,
          text: contact.name,
        ).click
    end

    assert_selector ".payment_invoice", count: 0
    assert_selector ".table-container.show-table",count: 0

    fill_in "Retención", with: 20_000
    fill_in "La suma de", with: 100_000
    fill_in "Por concepto de", with: "Test payment"
    select "Transferencia", from: "Método de pago"

    find(".datepicker-expense").click

    assert_selector ".flatpickr-calendar"

    within ".flatpickr-calendar" do
      find(".flatpickr-day.today").click
    end

    assert_difference 'Payment.count' do
      click_on "Crear"
    end
  end

  test "let a signed in user edit a payment" do
    setup

    assert_selector ".table-row-link", count: Payment.count

    payment = payments(:pago_factura_amg)

    within "[data-table-row-location='#{business_payment_path(@business, payment)}']" do
      find(".edit-property").click
    end

    assert_selector ".payment_invoice"
    assert_selector ".table-container.show-table"

    fill_in "La suma de", with: ""
    fill_in "La suma de", with: 5_000_000

    click_on "Editar"

    assert_selector ".invalid-feedback", text: /la suma de retención y valor recibido supera la deuda/

    within ".payment_retention_type" do
      find(".ss-arrow").click
      assert_selector ".ss-option:not(.ss-disabled)", count: Payment.retention_types.keys.size
      find(
        ".ss-option:not(.ss-disabled)",
        match: :prefer_exact,
        text: "Servicios en general - (6%)"
      ).click
    end
    fill_in "Retención", with: ""
    fill_in "Retención", with: 300_000

    fill_in "La suma de", with: ""
    fill_in "La suma de", with: 4_835_000

    click_on "Editar"

    payment.reload

    assert_equal payment.retention, 300_000.to_money
    assert_equal payment.total, 5_135_000.to_money
  end

  test "let a signed in user delete a payment" do
    payment_count = Payment.count

    accept_alert do
      find(".destroy-property", match: :first).click
    end

    assert_selector ".alert.alert-info.alert-dismissible"
    assert_equal payment_count - 1, Payment.count
  end
end
