require 'spec_helper'

describe CurrencyExchangeRatesCalculator do

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

  describe '#exchange_rate' do
    it 'returns the correct exchange rate' do
      allow(ExchangeRatesHash).to receive(:exchange_rates_hash).and_return(rates_hash)
      expect(CurrencyExchangeRatesCalculator.new("BGN").exchange_rate("EUR")).to eq(0.5113)
    end

    it 'returns the correct exchange rate through another currency' do
      allow(ExchangeRatesHash).to receive(:exchange_rates_hash).and_return(rates_hash)
      expect(CurrencyExchangeRatesCalculator.new("BGN").exchange_rate("GBP")).to eq(0.5113 * 0.77285)
    end

    it 'returns the correct exchange rate through deep conversion' do
      allow(ExchangeRatesHash).to receive(:exchange_rates_hash).and_return(rates_hash)
      expect(CurrencyExchangeRatesCalculator.new("BGN").exchange_rate("AUD")).to eq(0.5113 * 0.77285 * 1.9922)
    end

    it 'returns 0 when the currencies are not exchangeable' do
      expect(CurrencyExchangeRatesCalculator.new("USD").exchange_rate("BGN")).to eq(0)
    end

    it 'returns 1 when the target currency is the same as the given' do
      expect(CurrencyExchangeRatesCalculator.new("BGN").exchange_rate("BGN")).to eq(1)
    end

    it 'returns 0 when a non existing currency is given' do
      expect(CurrencyExchangeRatesCalculator.new("GOSHO").exchange_rate("PESHO")).to eq(0)
    end

    it 'returns 0 when invalid data is given' do
      expect(CurrencyExchangeRatesCalculator.new("PESHO").exchange_rate(nil)).to eq(0)
      expect(CurrencyExchangeRatesCalculator.new(nil).exchange_rate(1)).to eq(0)
    end
  end

  describe '#convert' do
    it 'converts given sum from one currency to another' do
      allow(ExchangeRatesHash).to receive(:exchange_rates_hash).and_return(rates_hash)
      expect(CurrencyExchangeRatesCalculator.new("BGN").convert(10, "EUR")).to eq(10 * 0.5113)
    end
  end
end

