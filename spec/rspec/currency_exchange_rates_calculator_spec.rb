require 'spec_helper'

describe CurrencyExchangeRatesCalculator do
  describe '#exchange_rate' do
    it 'returns the correct exchange rate' do
      expect(CurrencyExchangeRatesCalculator.new("BGN").exchange_rate("EUR")).to eq(0.5113)
    end

    it 'returns 0 when the currencies are not exchangeable' do
      expect(CurrencyExchangeRatesCalculator.new("USD").exchange_rate("BGN")).to eq(0)
    end
  end
end