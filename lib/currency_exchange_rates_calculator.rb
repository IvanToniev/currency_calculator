require 'json'
require './lib/exchange_path_finder'
require './lib/exchange_rates_hash'
require 'pp'

class CurrencyExchangeRatesCalculator

  def initialize currency_name
    @currency_name = currency_name
  end

  def convert quantity, target_currency
    quantity * exchange_rate(target_currency)
  end

  def exchange_rate target_name
    exchange_rates_hash = ExchangeRatesHash.exchange_rates_hash
    path = ExchangePathFinder.new(exchange_rates_hash.clone, @currency_name).path(target_name, exchange_rates_hash.clone[@currency_name])
    rate = 1

    path_clone = path.clone

    until path_clone.size == 1
      rate *= exchange_rates_hash.deep_fetch(*path_clone)
      path_clone.pop
    end

    rate
  end
end


