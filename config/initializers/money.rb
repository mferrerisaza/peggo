Money.use_i18n = false
MoneyRails.configure do |config|
  config.register_currency = {
      :priority            => 1,
      :iso_code            => "COL",
      :name                => "Peso Colombiano",
      :symbol              => "$",
      :symbol_first        => true,
      :subunit             => "Cent",
      :subunit_to_unit     => 100,
      :thousands_separator => ",",
      :decimal_mark        => "."
  }
  config.default_currency = :col
  # config.default_format = {
  #   thousands_separator: ",",
  #   decimal_mark:        "."
  # }
end
