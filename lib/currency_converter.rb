require './lib/currency_exchange_rates_extractor'

class CurrencyConverter

  def exchange_rate first_currency, second_currency
    CurrencyExchangeRatesExtractor.new(first_currency).exchange_rate(second_currency)
  end

  def convert quantity,  first_currency, second_currency
    exchange_rate = CurrencyExchangeRatesExtractor.new(first_currency).exchange_rate(second_currency)
    quantity * exchange_rate
  end
end