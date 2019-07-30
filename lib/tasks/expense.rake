namespace :expense do
  desc "Migrates old expenses with only one description and amount to expense with concept"
  task migrate_description_to_concept: :environment do
    expenses = Expense.all
    expenses.each do |expense|
      MigrateExpenseDescriptionAndAmountToConceptJob.perform_later(expense.id)
    end
  end
end
