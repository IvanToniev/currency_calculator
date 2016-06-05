require 'spec_helper'

describe Currency do
  let(:currency) {Currency.new("EUR")}

  describe '#exchange_rate' do
    it 'returns the exchange rate between the two currencies' do
      expect(currency.exchange_rate("BRL")).to eq(3.9973)
    end
  end

  describe '#convert' do
    it 'converts a quantity of money from one currency to another' do
      expect(currency.convert(10, "BRL")).to eq(10 * 3.9973)
    end
  end
end