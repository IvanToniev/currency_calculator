require 'spec_helper'

describe ExchangePathFinder do

  let(:rates_hash) {
    {
      "EUR" => {
        "BGN" => 1.9558,
        "GBP" => 0.77285,
      },
      "GBP" => {
        "AUD" => 1.9922
      },
      "BGN" => {
        "JPY" => 62.108,
        "USD" => 0.5703,
        "EUR" => 0.5113,
        "CZK" => 13.818
      }
    }.extend Hashie::Extensions::DeepFetch
  }

  describe '#path' do
    it 'can find flat road' do
      allow(ExchangeRatesHash).to receive(:exchange_rates_hash).and_return(rates_hash)

      currency_name = "BGN"
      target_currency = "EUR"

      path = ExchangePathFinder.new(rates_hash.clone, currency_name).path(target_currency, rates_hash.clone[currency_name])
      expect(path.size).to eq(2)
      expect(path).to include(currency_name)
      expect(path).to include(target_currency)
    end

    it 'can find deep road' do
      allow(ExchangeRatesHash).to receive(:exchange_rates_hash).and_return(rates_hash)

      currency_name = "BGN"
      target_currency = "AUD"

      path = ExchangePathFinder.new(rates_hash.clone, currency_name).path(target_currency, rates_hash.clone[currency_name])
      expect(path.size).to eq(4)
      expect(path).to include(currency_name)
      expect(path).to include("GBP")
      expect(path).to include("EUR")
      expect(path).to include(target_currency)
    end

    it 'returns empty array if the target is the start' do
      allow(ExchangeRatesHash).to receive(:exchange_rates_hash).and_return(rates_hash)

      currency_name = "BGN"
      target_currency = "BGN"

      path = ExchangePathFinder.new(rates_hash.clone, currency_name).path(target_currency, rates_hash.clone[currency_name])
      expect(path).to eq([])
    end

    it 'returns empty array if target_currency is nil, empty' do
      allow(ExchangeRatesHash).to receive(:exchange_rates_hash).and_return(rates_hash)

      currency_name = "BGN"

      path = ExchangePathFinder.new(rates_hash.clone, currency_name).path(nil, rates_hash.clone[currency_name])
      expect(path).to eq([])
    end

    it 'returns empty array if there is no hash passed' do
      allow(ExchangeRatesHash).to receive(:exchange_rates_hash).and_return(rates_hash)

      currency_name = "BGN"
      target_currency = "EUR"

      path = ExchangePathFinder.new(rates_hash.clone, currency_name).path(target_currency, nil)
      expect(path).to eq([])
    end
  end
end

