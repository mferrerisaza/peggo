namespace :db do
  desc "Backs up heroku database and restores it locally."
  task import_from_heroku: [:environment, :create] do
    HEROKU_APP_NAME = nil # Change this if app name is not picked up by `heroku` git remote.

    c = Rails.configuration.database_configuration[Rails.env]
    heroku_app_flag = HEROKU_APP_NAME ? " --app #{HEROKU_APP_NAME}" : nil
    Bundler.with_clean_env do
      puts "[1/4] Capturing backup on Heroku"
      `heroku pg:backups capture DATABASE_URL#{heroku_app_flag}`
      puts "[2/4] Downloading backup onto disk"
      `curl -o tmp/latest.dump \`heroku pg:backups public-url #{heroku_app_flag} | cat\``
      puts "[3/4] Mounting backup on local database"
      `pg_restore --clean --verbose --no-acl --no-owner -h localhost -d #{c["database"]} tmp/latest.dump`
      puts "[4/4] Removing local backup"
      `rm tmp/latest.dump`
      puts "Done."
    end
  end

  desc "Change printed status of old documents (before printed funcionallity)"
  task marked_old_documents_as_printed: :environment do
    models = ["Expense", "Invoice", "InvoiceEquivalent", "Payment"]

    models.each do |model_to_retrieve|
      model_to_retrieve.constantize.where("date < ?", 34.days.ago.midnight).each do |record|
        puts "Actualizando #{model_to_retrieve} número: #{record.number}"
        record.update(printed: true)
      end
    end
  end

  desc "Change printed status to false"
  task marked_documents_as_not_printed: :environment do
    models = ["Expense", "Invoice", "InvoiceEquivalent", "Payment"]

    models.each do |model_to_retrieve|
      model_to_retrieve.constantize.all.each do |record|
        puts "Actualizando #{model_to_retrieve} número: #{record.number}"
        record.update(printed: false)
      end
    end
  end
end
