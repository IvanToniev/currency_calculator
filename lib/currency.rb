require './lib/currency_exchange_rates_calculator'

class Currency
  #array of exchange rate object
  attr_accessor :name

  def initialize currency_name
    @name = currency_name
  end

  def exchange_rate target_currency
    CurrencyExchangeRatesCalculator.new(@name).exchange_rate(target_currency)
  end

  def convert quantity, target_currency
    CurrencyExchangeRatesCalculator.new(@name).convert(quantity, target_currency)
  end
end