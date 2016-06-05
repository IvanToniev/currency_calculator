require 'json'
require 'pp'

class CurrencyExchangeRatesExtractor

  def initialize currency_name
    @currency_name = currency_name
  end

  def available_exchange_rates
    Graph.new(exchange_rates_hash.clone, @currency_name).available_nodes(@currency_name)
  end

  def exchange_rates
    # Graph.new(exchange_rates_hash.clone, @currency_name).nodes(@currency_name)
    Graph.new(exchange_rates_hash.clone, @currency_name).graph_edges(@currency_name, exchange_rates_hash.clone)
  end

  def exchange_rate second_currency
    selected_rate = exchange_rates.select{|rate| rate.first_currency == @currency_name && rate.second_currency == second_currency}.first
    selected_rate.rate
  end

  # def complex_exchange prev, second_currency
  #   hash = exchange_rates_hash.clone
  #   rate = 1

  #   hash[prev].each do |node_data|
  #     currency_name = node_data.first
  #     exchange_rate = node_data.last

  #     if hash[currency_name].is_a? Hash
  #       complex_exchange(currency_name, second_currency)
  #     else
  #       rate = rate * exchange_rate
  #     end
  #   end

  #   rate
  # end

  private
  def exchange_rates_hash
    file = File.read('./data/rates.json')
    JSON.parse(file)
  end
end

class Graph
  def initialize hash, parent_node_name
    @hash = hash
  end

  def graph_edges parent_name, edge_hash
    edges = []

    edge_hash[parent_name].each do |node_data|
      currency_name = node_data.first
      exchange_rate = node_data.last

      if edge_hash[currency_name].is_a? Hash
        edge_hash[currency_name].delete(parent_name) if edge_hash[parent_name]


        edges << graph_edges(currency_name, edge_hash[parent_name])
      else
        edges << [currency_name, exchange_rate]
      end
    end

    edges
  end

  def nodes parent_name
    rates = []

    @hash[parent_name].each do |node_data|
      currency_name = node_data.first
      exchange_rate = node_data.last

      if @hash[currency_name].is_a? Hash
        # child_hash = @hash[currency_name]
        # child_hash.delete(parent_name) if child_hash[parent_name]

        # nodes(currency_name)
        next
      else
        rates << ExchangeRate.new(parent_name, currency_name, exchange_rate)
        @hash[parent_name].delete(currency_name)
      end
    end

    rates.flatten.uniq
  end

  def available_nodes parent_node
    nodes = []
    nodes << parent_node

    @hash[parent_node].each do |node_data|
      currency_name = node_data.first
      exchange_rate = node_data.last

      if @hash[currency_name].is_a? Hash
        child_hash = @hash[currency_name]
        child_hash.delete(parent_node)

        nodes << available_nodes(currency_name)
      else
        nodes << currency_name
        @hash[parent_node].delete(currency_name)
      end
    end

    nodes.flatten.uniq
  end
end

class ExchangeRate
  attr_accessor :first_currency, :second_currency, :rate

  def initialize first_currency, second_currency, rate
    @first_currency = first_currency
    @second_currency = second_currency
    @rate = rate
  end
end
