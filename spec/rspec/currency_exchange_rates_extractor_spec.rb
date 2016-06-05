require 'spec_helper'
require 'pp'

describe CurrencyExchangeRatesExtractor do
  describe '#available_exchange_rates' do
    it 'returns all available exchange rates' do
      expect(CurrencyExchangeRatesExtractor.new("EUR").available_exchange_rates.count).to eq(32)
      expect(CurrencyExchangeRatesExtractor.new("EUR").available_exchange_rates).to include("EUR")
    end
  end

  describe '#exchange_rates' do
    it 'returns exchange rate objects' do
      pp CurrencyExchangeRatesExtractor.new("EUR").exchange_rates
    end
  end

  describe '#complex_exchange' do
    pp CurrencyExchangeRatesExtractor.new("BGN").complex_exchange("GBP")
  end
end