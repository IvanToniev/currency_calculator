require 'spec_helper'

describe CurrencyExchangeRatesCalculator do
  describe '#exchange_rate' do
    it 'returns the way to the target' do
      expect(CurrencyExchangeRatesCalculator.new("BGN").exchange_rate("EUR")).to eq(0.5113)
    end
  end
end