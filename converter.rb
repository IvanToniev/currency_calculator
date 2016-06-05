require './lib/currency'

puts 'Enter currencies'
convertibles = gets.chomp.split(' ')

input_size = convertibles.size

if input_size == 2
  first_currency = convertibles.first
  second_currency = convertibles.last
  puts Currency.new(first_currency).exchange_rate(second_currency)
else
  quantity = convertibles.first
  first_currency = convertibles.second
  second_currency = convertibles.last
  puts Currency.new(first_currency).convert(quantity, second_currency)
end