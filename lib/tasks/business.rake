namespace :business do
  desc "Adds default inovice texts to existing business"
  task update_invoice_texts: :environment do
    puts "Iniciando actualización"
    businesses = Business.all
    businesses.each do |business|
      puts "Actualizando #{business.name}"
      business.update!(
        invoice_resolution_number: "Resolución Autorización por Computador DIAN N° 18762013589371 del 20/03/2019 del 1 HASTA 500 - Vigencia 24 Meses",
        invoice_terms_and_conditions: "1. Esta factura de venta se asimila en todos sus efectos legales a una letra de cambio según el artículo No. 671 y S.S. 772-774 del código de comercio.\n2. En caso de mora se causara el interés autorizado por la ley.",
        invoice_notes: "Pagos por consignación o transferencia bancaria a la Cuenta de Ahorros BANCOLOMBIA a nombre de SCUAD S.A.S No. 02900017858.\nFavor anunciar su pago al correo electrónico nosotros@scuad.co"
      )
    end
    puts "Actualización terminada"
  end
end
