module Year2021
  class Day03
    def part1(input)
      input = parse_input(input)
      
      counts = get_bit_counts(input)

      gamma_rate = epsilon_rate = ""
      total_lines = input.size
      counts.sort.to_h.each do |index, count|
        if count >= (total_lines / 2)
          gamma_rate = gamma_rate + "1"
          epsilon_rate = epsilon_rate + "0"
        else
          gamma_rate = gamma_rate + "0"
          epsilon_rate = epsilon_rate + "1"
        end
      end

      gamma_rate_dec = gamma_rate.to_i(2)
      epsilon_rate_dec = epsilon_rate.to_i(2)

      gamma_rate_dec * epsilon_rate_dec
    end

    def part2(input)
      input = parse_input(input)

      oxygen_rating = co2_rating = ""
      oxygen_rating = get_rating_value(:oxygen, input.dup).join
      co2_rating = get_rating_value(:co2, input.dup).join

      oxygen_rating.to_i(2) * co2_rating.to_i(2)
    end

    # Helpers
    def parse_input(input)
      input.split("\n").map{|line| line.split('')}
    end

    def get_bit_counts(input)
      counts = {}
      input.each do |bin_num|
        bin_num.each_with_index do |bit, index|
          next if bit != "1"
          counts[index] ||= 0
          counts[index] = counts[index] + 1
        end
      end
      counts
    end

    def get_rating_value(rating_type, numbers_to_consider)
      counts = {}
      (0..numbers_to_consider.first.size).to_a.each do |bit_index|
        counts[bit_index] ||= {"0" => [], "1" => []}
        numbers_to_consider.each do |bin_num|
          bit = bin_num[bit_index]
          counts[bit_index][bit] ||= []
          counts[bit_index][bit].push(bin_num)
        end
        compare_op = rating_type == :oxygen ? ">=" : "<"
        zeros, ones = counts[bit_index]["0"], counts[bit_index]["1"]
        numbers_to_consider = ones.size.public_send(compare_op, zeros.size) ? ones : zeros
        return numbers_to_consider.first if numbers_to_consider.size == 1
      end
      return numbers_to_consider.first
    end
  end
end
