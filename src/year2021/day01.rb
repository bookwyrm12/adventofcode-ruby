module Year2021
  class Day01
    def part1(input)
      input = parse_input(input)
      increases_arr = input.to_enum(:each_with_index).map do |depth, i|
        # puts "#{i.inspect} - #{depth.inspect}"
        if i == 0
          0
        else
          depth > input[i - 1] ? 1 : 0
        end
      end
      count_increases = increases_arr.reduce(:+)
      count_increases
    end

    def part2(input)
      input = parse_input(input)
      prev_sliding_window_sum = nil
      increases_arr = input.to_enum(:each_with_index).map do |depth, i|
        if i < 2
          0
        else
          sliding_window_sum = input[i-2..i].reduce(:+)
          
          if prev_sliding_window_sum.nil?
            prev_sliding_window_sum = sliding_window_sum
            0
          else
            tmp_prev_sliding_window_sum = prev_sliding_window_sum
            prev_sliding_window_sum = sliding_window_sum
            sliding_window_sum > tmp_prev_sliding_window_sum ? 1 : 0 
          end
        end
      end
      count_increases = increases_arr.reduce(:+)
      count_increases
    end

    # Helpers
    def parse_input(input)
      input.split("\n").map{|x| x.to_i}
    end
  end
end
