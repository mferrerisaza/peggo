namespace :business do
  desc "Adds default inovice texts to existing business"
  task update_invoice_texts: :environment do
    puts "Iniciando actualización"
    businesses = Business.all
    businesses.each do |business|
      puts "Actualizando #{business.name}"
      business.update!(
        invoice_resolution_number: Business::INVOICE_RESOLUTION_NUMBER,
        invoice_terms_and_conditions: Business::INVOICE_TERMS_AND_CONDITIONS,
        invoice_notes: Business::INVOICE_NOTES
      )
    end
    puts "Actualización terminada"
  end
end
