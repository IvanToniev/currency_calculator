class Currency
  #array of exchange rate object
  attr_accessor :name
  attr_reader :available_exchange_rates

  def initialize currency_name
    @name = currency_name
    @available_exchange_rates = CurrencyExchangeRatesExtractor.new(@name).exchange_rates
  end
end