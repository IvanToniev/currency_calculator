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

  # let(:currency) {Currency.new("EUR")}

  # describe '#exchange_rate' do
  #   it 'returns the exchange rate between the two currencies' do
  #     expect(currency.exchange_rate("BRL")).to eq(3.9973)
  #   end
  # end

  # describe '#convert' do
  #   it 'converts a quantity of money from one currency to another' do
  #     expect(currency.convert(10, "BRL")).to eq(10 * 3.9973)
  #   end
  # end
end

