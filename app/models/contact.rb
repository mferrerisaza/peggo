class Contact < ApplicationRecord
  belongs_to :business
  has_many :expenses, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :payments, dependent: :destroy

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
end
