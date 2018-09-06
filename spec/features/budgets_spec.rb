require 'rails_helper'

RSpec.feature "Budgets", type: :feature do
  before do
    @user = FactoryBot.create(:user, :with_buildings)
    @building = @user.buildings.first
    @building_with_budget = FactoryBot.create(:building, :with_active_budget, user: @user)
  end

  scenario "user creates a budget", js: true do
    sign_in_as @user
    go_to_building_budget_index @building.name
    expect(page).to have_content "Aún no tienes ningún presupuesto activo, agrega uno para comenzar"
    go_to_budget_form("new")
    fill_budget_form
    expect_budget_correct_creation(@building.budgets.first)
  end

  scenario "user edits an active budget status", js: true do
    sign_in_as @user
    go_to_building_budget_index @building_with_budget.name
    expect(page).to have_content "Presupuesto Activo"
    go_to_budget_form("edit")
    edit_budget_form_status @building_with_budget.budgets.first
  end

  scenario "user deletes an active budget", js: true do
    sign_in_as @user
    go_to_building_budget_index @building_with_budget.name
    expect(page).to have_content "Presupuesto Activo"
    go_to_budget_form("destroy")
    confirm_budget_delete @building_with_budget
  end

  def go_to_building_budget_index(name)
    click_link name
    page.driver.browser.manage.window.resize_to(1024, 768)
    click_link "Presupuesto"
  end

  def go_to_budget_form(action)
    if action == "new"
      find(".mdc-fab").click
      expect(page).to have_css("#new_budget")
    elsif action == "edit"
      find(".edit-budget").click
      expect(page).to have_css("#edit_budget_#{@building_with_budget.budgets.first.id}")
    elsif action == "destroy"
      find(".destroy-budget").click
    end
  end

  def fill_budget_form
    expect do
      find("input[placeholder='Ej: Ene 2018']").click
      expect(page).to have_css(".flatpickr-calendar.animate.open.arrowTop")
      find(".flatpickr-day.today").click
      find("input[placeholder='Ej: Dic 2018']").click
      expect(page).to have_css(".flatpickr-calendar.animate.open.arrowTop")
      find(".flatpickr-day.today").click
      fill_in "Presupuesto para el período", with: 120_000_000
      click_button "Crear"
    end.to change(@building.budgets, :count).by 1
  end

  def edit_budget_form_status(budget)
    expect do
      uncheck "Utilizar como presupuesto activo"
      click_button "Editar"
      budget.reload
      expect(page).to have_content "Aún no tienes ningún presupuesto activo, agrega uno para comenzar"
    end.to change(budget, :status).from(true).to(false)
  end

  def confirm_budget_delete(building)
    expect do
      expect(page.driver.browser.switch_to.alert.text).to eq "¿Estás seguro?"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content "Presupuesto eliminado con éxito"
    end.to change(building.budgets, :count).by(-1)
  end

  def expect_budget_correct_creation(budget)
    expect(page).to have_content "Presupuesto creado con éxito"
    expect(page).to_not have_content "Aún no tienes ningún presupuesto activo, agrega uno para comenzar"
    expect(budget.start_date).to eq Date.current.beginning_of_month
    expect(budget.end_date).to eq Date.current.end_of_month
  end
end
