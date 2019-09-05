require "application_system_test_case"

class ExpensesTest < ApplicationSystemTestCase
  setup do
    login_as users(:mike)
    @business = businesses(:xloop)
    visit "/"
    find(".card").click
    within "#mySidenav" do
      click_on "Egresos"
    end
  end

  test "concepts nested fields form adds an removes associations" do
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

  test "let a signed in user create an expense within a business" do
    find(".mdc-fab.fab-bottom-right.fab-color").click
    select "Transferencia", from: "Método de pago"
    find(".datepicker-expense").click
    assert_selector ".flatpickr-calendar"
    within ".flatpickr-calendar" do
      find(".flatpickr-day.today").click
    end

    click_on "Agregar línea"
    assert_selector ".nested-fields", count: 1

    find(".expense_concepts_name input").set "Pago Industria y Comercio"
    find(".expense_concepts_quantity input").set 2
    find(".expense_concepts_amount input").set ""
    find(".expense_concepts_amount input").set 100000

    subotal_input = find("#expense_subtotal")
    vat_input = find("#expense_vat")
    total_input = find("#expense_total")
    concept_total = find(".expense_concepts_fake_total input")
    expense_retention = find(".expense_retention input")

    assert_equal "200,000", concept_total.value
    assert_equal "200,000", subotal_input.value
    assert_equal "200,000", total_input.value

    find(".expense_concepts_vat input").set 0.19

    assert_equal "200,000", concept_total.value
    assert_equal "200,000", subotal_input.value
    assert_equal "38,000", vat_input.value
    assert_equal "238,000", total_input.value

    select "Servicios en general - (4%)", from: "Tipo de retención"

    assert_equal "200,000", subotal_input.value
    assert_equal "38,000", vat_input.value
    assert_equal "8,000", expense_retention.value

    find(".ss-single-selected").click
    sleep(1)
    assert_selector ".ss-option:not(.ss-disabled)", count: Contact.where(business: @business).where(provider: true).size
    find(".ss-option:not(.ss-disabled)", match: :first).click

    assert_equal "230,000", total_input.value
    assert_difference 'Expense.count' do
      click_on "Crear"
    end
  end

  test "let a signed in user edit an expense" do
    setup

    assert_selector ".table-row-link", count: Expense.count
    expense = expenses(:industria_y_comercio)
    concept = concepts(:industria_y_comercio_concept)

    within "[data-table-row-location='#{business_expense_path(@business, expense)}']" do
      find(".edit-property").click
    end

    assert_selector ".nested-fields", count: expense.concepts.size

    subotal_input = find("#expense_subtotal")
    vat_input = find("#expense_vat")
    total_input = find("#expense_total")
    concept_total = find(".expense_concepts_fake_total input")
    expense_retention = find(".expense_retention input")

    assert_equal "34,000.00", concept_total.value
    assert_equal "34,000.00", subotal_input.value
    assert_equal "0.00", vat_input.value
    assert_equal "34,000.00", total_input.value

    find(".expense_concepts_name input").set "Pago Industria y Comercio Editado"
    find(".expense_concepts_quantity input").set 2
    find(".expense_concepts_amount input").set ""
    find(".expense_concepts_amount input").set 100000
    find(".expense_concepts_vat input").set 0.19
    select "Servicios en general - (4%)", from: "Tipo de retención"

    click_on "Editar"

    expense.reload
    concept.reload

    assert_equal expense.total, 230_000.to_money
    assert_equal "Pago Industria y Comercio Editado", concept.name
  end

  test "let a signed in user delete an expense" do
    expense_count = Expense.count

    accept_alert do
      find(".destroy-property", match: :first).click
    end

    assert_selector ".alert.alert-info.alert-dismissible"
    assert_equal expense_count - 1, Expense.count
  end

  test "user can change print status from index" do
    expense = expenses(:industria_y_comercio)

    within "[data-table-row-location='#{business_expense_path(@business, expense)}']" do
      check "printed"
    end

    sleep 0.1

    expense.reload
    assert expense.printed
  end
end
