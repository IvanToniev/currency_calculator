require './lib/currency_exchange_rates_calculator'


class UserInputProcessor
  def self.process_input input_size, convertibles
    if input_size == 2
      first_currency = convertibles.first
      second_currency = convertibles.last
      rate = CurrencyExchangeRatesCalculator.new(first_currency).exchange_rate(second_currency)
      return 'Conversion rate unavailable' if rate == 0
      return "1 #{first_currency} = #{rate} #{second_currency}"
    elsif input_size == 3
      quantity = convertibles.first
      first_currency = convertibles[1]
      second_currency = convertibles.last
      converted_quantity = CurrencyExchangeRatesCalculator.new(first_currency).convert(quantity, second_currency)
      return 'Conversion rate unavailable' if converted_quantity == 0
      return "#{quantity} #{first_currency} = #{converted_quantity} #{second_currency}"
    else
      return 'Enter correct currency codes'
    end
  end
end

#uncomment the loop if you want the convert to not stop working after conversion (brake by pressing ctrl+c)
#loop do
puts 'Enter currencies to convert or check conversion rate:'
convertibles = gets.chomp.split(' ')
input_size = convertibles.size

puts UserInputProcessor.process_input(input_size, convertibles)
#end
