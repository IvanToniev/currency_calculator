require 'json'
require './lib/exchange_path_finder'
require './lib/exchange_rates_hash'

class CurrencyExchangeRatesCalculator

  def initialize currency_name
    @currency_name = currency_name
  end

  def convert quantity, target_currency
    quantity.to_f * exchange_rate(target_currency).to_f
  end

  def exchange_rate target_name
    return 1 if @currency_name == target_name

    exchange_rates_hash = ExchangeRatesHash.exchange_rates_hash
    return 0 if exchange_rates_hash.empty?

    path = ExchangePathFinder.new(exchange_rates_hash.clone, @currency_name).path(target_name, exchange_rates_hash.clone[@currency_name])
    return 0 if path.empty?


    rate = 1

    until path.size == 1
      rate *= exchange_rates_hash.deep_fetch(*path.last(2))
      path.pop
    end

    rate
  end
end


