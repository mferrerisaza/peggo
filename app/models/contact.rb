class Contact < ApplicationRecord
  belongs_to :business
  has_many :expenses, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :invoice_equivalents, dependent: :destroy

  enum tax_id_type: [
    "NIT - Número de identificación tributaria",
    "CC - Cédula de ciudadanía",
    "DIE - Documento de identificación extranjero",
    "PP - Pasaporte",
    "CE - Cédula de extranjería",
    "TE - Tarjeta de extranjería",
    "TI - Tarjeta de identidad",
    "RC - Registro civil",
    "NA - No Aplica"
  ]

  enum account_type: [
    "Ahorros",
    "Corriente"
  ]

  enum account_bank: [
    "BANCO AGRARIO",
    "BANCO AV VILLAS",
    "BANCO BBVA COLOMBIA S.A.",
    "BANCO CAJA SOCIAL",
    "BANCO COLPATRIA",
    "BANCO COOPERATIVO COOPCENTRAL",
    "BANCO DAVIVIENDA",
    "BANCO DE BOGOTA",
    "BANCO DE OCCIDENTE",
    "BANCO FALABELLA ",
    "BANCO GNB SUDAMERIS",
    "BANCO PICHINCHA S.A.",
    "BANCO POPULAR",
    "BANCO PROCREDIT",
    "BANCO SANTANDER COLOMBIA",
    "BANCOLOMBIA",
    "BANCOOMEVA S.A.",
    "CITIBANK ",
    "CONFIAR COOPERATIVA FINANCIERA",
    "DAVIPLATA",
    "ITAU",
    "NEQUI"
  ]


  validates :name, :tax_id_type, :tax_id, presence: true

  def full_address
    return "" if address.blank?
    return "#{address}" if city.blank? && province.blank?
    return "#{address} - #{city}" if province.blank?
    return "#{address} - #{city}, #{province}"
  end

  def phone_numbers_label_for_pdf
    return "TELÉFONO" if cell_phone.blank? || phone.blank?
    return "TELÉFONOS" if cell_phone && phone
  end

  def phone_numbers
    return "" if cell_phone.blank? && phone.blank?
    return "#{cell_phone}" if cell_phone && phone.blank?
    return "#{phone}" if phone && cell_phone.blank?
    return "#{phone} - #{cell_phone}" if cell_phone && phone
  end

  def bank_account
    return if account_number.blank?
    "#{account_type} #{account_bank} No: #{account_number}"
  end
end
