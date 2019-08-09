require "application_system_test_case"

class InvoicesTest < ApplicationSystemTestCase
  setup do
    login_as users(:mike)
    @business = businesses(:xloop)
    visit "/"
    find(".card").click
    within "#mySidenav" do
      click_on "Facturas"
    end
  end

  test "items nested fields form adds an removes associations" do
    find(".mdc-fab.fab-bottom-right.fab-color").click

    2.times do
      click_on "Agregar línea"
    end

    assert_selector ".nested-fields", count: 2

    within ".nested-fields", match: :first do
      find("[data-action~='click->nested-form#remove_association']").click
    end

    assert_selector ".nested-fields", count: 1
  end

  test "let a signed in user create an invoice within a business" do
    find(".mdc-fab.fab-bottom-right.fab-color").click
    within ".invoice_contact" do
      find(".ss-single-selected").click
      assert_selector ".ss-option:not(.ss-disabled)", count: Contact.where(business: @business).where(client: true).size
      find("
        .ss-option:not(.ss-disabled)",
        match: :prefer_exact,
        text: contacts(:client).name
      ).click
    end
    within ".invoice_date" do
      find(".datepicker-expense").click
    end
    assert_selector ".flatpickr-calendar"
    within ".flatpickr-calendar" do
      find(".flatpickr-day.today").click
    end
    expiration_date_input = find(".expiration-date:not(.hidden)")
    assert_not_empty expiration_date_input.value

    click_on "Agregar línea"
    assert_selector ".nested-fields", count: 1
    within ".nested-fields" do
      find(".ss-single-selected").click
      assert_selector ".ss-content.ss-open"
      assert_selector ".ss-search input"
      page.execute_script("document.querySelector('.nested-fields .ss-search input').value = 'Asesoria'")
      find(".ss-search .ss-addable").click
    end
    find(".invoice_items_quantity input").set 1
    find(".invoice_items_price input").set ""
    find(".invoice_items_price input").set 1_000_000
    find(".invoice_items_discount input").set 0.1
    find(".invoice_items_vat input").set 0.2

    item_total = find(".invoice_items_fake_total input")
    gross_subotal_input = find("#invoice-gross-total")
    discount_total_input = find("#invoice-total-discount")
    net_subtotal_input = find("#invoice-net-total")
    vat_input = find("#invoice-total-vat")
    total_input = find("#invoice-grand-total")

    assert_equal "1,000,000", gross_subotal_input.value
    assert_equal "-100,000", discount_total_input.value
    assert_equal "900,000", net_subtotal_input.value
    assert_equal "180,000", vat_input.value
    assert_equal "1,080,000", total_input.value

    invoice_count = Invoice.count
    item_count = Item.count

    click_on "Crear"

    assert_equal invoice_count + 1, Invoice.count
    assert_equal item_count + 1, Item.count
  end

  test "let a signed in user edit an invoice" do
    setup

    assert_selector ".table-row-link", count: Invoice.count
    invoice = invoices(:factura_amg)

    within "[data-table-row-location='#{business_invoice_path(@business, invoice)}']" do
      find(".edit-property").click
    end

    assert_selector ".nested-fields", count: invoice.items.size

    gross_subotal_input = find("#invoice-gross-total")
    discount_total_input = find("#invoice-total-discount")
    net_subtotal_input = find("#invoice-net-total")
    vat_input = find("#invoice-total-vat")
    total_input = find("#invoice-grand-total")

    assert_equal "5,000,000.00", gross_subotal_input.value
    assert_equal "-250,000.00", discount_total_input.value
    assert_equal "4,750,000.00", net_subtotal_input.value
    assert_equal "385,000.00", vat_input.value
    assert_equal "5,135,000.00", total_input.value

    2.times do
      within ".nested-fields", match: :first do
        find("[data-action~='click->nested-form#remove_association']").click
      end
    end

    sleep(1)

    assert_equal "1,000,000", gross_subotal_input.value
    assert_equal "0", discount_total_input.value
    assert_equal "1,000,000", net_subtotal_input.value
    assert_equal "100,000", vat_input.value
    assert_equal "1,100,000", total_input.value

    item_count = Item.count

    click_on "Editar"

    invoice.reload

    assert_equal invoice.total, 1_100_000.to_money
    assert_equal item_count - 2, Item.count
  end

  test "let a signed in user delete an invoice" do
    invoice_count = Invoice.count

    accept_alert do
      find(".destroy-property", match: :first).click
    end

    assert_selector ".alert.alert-info.alert-dismissible"
    assert_equal invoice_count - 1, Invoice.count
  end
end
