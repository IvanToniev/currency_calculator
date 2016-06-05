class ExchangePathFinder
  def initialize hash, path_start_name
    @hash = hash
    @path_start_name = path_start_name
  end

  def path target_name, current_hash
    path = path_stops(target_name, current_hash, [@path_start_name]) << @path_start_name

    # no path to the currency
    return [] if path.size == 1

    return path.reverse
  end

  private
  def path_stops target_name, current_hash, visited_hash_names
    return [] unless current_hash
    return [] if target_name.empty?

    stop_names = []
    not_visited_hashes = []

    # delete loops from path
    visited_hash_names.map{ |name| current_hash.delete(name) }

    # bottom of recursion
    if current_hash[target_name]
      stop_names << target_name
      return stop_names
    end

    current_hash.each do |currency_name, exchange_rate|
      not_visited_hash = { currency_name => @hash[currency_name] }
      not_visited_hashes << not_visited_hash if @hash[currency_name].is_a?(Hash)
    end

    return [] if not_visited_hashes.empty?

    until not_visited_hashes.empty?
      # Push the hash key in the visited hashes
      last_visited_hash_name = not_visited_hashes.last.keys.first
      last_visited_hash_data = not_visited_hashes.last.values.first
      visited_hash_names = visited_hash_names << last_visited_hash_name

      # recursion here
      result = path_stops(target_name, last_visited_hash_data, visited_hash_names)

      # remove hash from not visited
      last_visited = not_visited_hashes.pop

      # check if we have a match and brake loop if so
      unless result.empty?
        stop_names << result
        stop_names << last_visited.keys.first
        return stop_names.flatten if result.first == target_name
      end
    end

    stop_names.flatten
  end
end