require 'spec_helper'

describe CurrencyConverter do
  describe '#exchange_rate' do
    it 'returns the exchange rate between the two currencies' do
      expect(CurrencyConverter.new.exchange_rate("EUR", "BRL")).to eq(3.9973)
    end
  end

  describe '#convert' do
    it 'converts a quantity of money from one currency to another' do
      expect(CurrencyConverter.new.convert(10, "EUR", "BRL")).to eq(10 * 3.9973)
    end
  end
end