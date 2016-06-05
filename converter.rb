require './lib/currency_converter'

puts 'Enter currencies'
convertibles = gets.chomp

input_size = convertibles.split(' ').size

if input_size == 2
  first_currency = convertibles.first
  second_currency = convertibles.last
  puts CurrencyConverter.new.exchange_rate first_currency, second_currency
else
  quantity = convertibles.first
  first_currency = convertibles.second
  second_currency = convertibles.last
  puts CurrencyConverter.new.convert quantity, first_currency, second_currency
end