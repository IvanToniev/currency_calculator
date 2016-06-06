require 'hashie'

class ExchangeRatesHash < Hash
  def self.exchange_rates_hash
    file = File.read('./data/rates.json')
    JSON.parse(file).extend Hashie::Extensions::DeepFetch
  end
end