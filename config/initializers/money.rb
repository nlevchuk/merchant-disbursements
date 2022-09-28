# encoding : utf-8

MoneyRails.configure do |config|
  config.default_currency = :eur

  config.rounding_mode = BigDecimal::ROUND_HALF_EVEN

  # Set default money format globally.
  # Default value is nil meaning "ignore this option".
  # Example:
  #
  # config.default_format = {
  #   no_cents_if_whole: nil,
  #   symbol: nil,
  #   sign_before_symbol: nil
  # }

  config.locale_backend = nil

  config.raise_error_on_money_parsing = true
end
