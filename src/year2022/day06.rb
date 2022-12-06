module Year2022
  class Day06
    def part1(input)
      input = parse_input(input)
      pos = 0
      counts = {}

      input.each_char do |char|
        pos += 1
        counts[char] ||= 0
        counts[char] += 1
        next if pos <= 4

        counts[input[pos - 5]] -= 1
        found_marker = counts.values.select{|count| count > 1}.length == 0
        return pos if found_marker
      end
    end

    def part2(input)
      input = parse_input(input)
      pos = 0
      counts = {}
      
      input.each_char do |char|
        pos += 1
        counts[char] ||= 0
        counts[char] += 1
        next if pos <= 14

        counts[input[pos - 15]] -= 1
        found_marker = counts.values.select{|count| count > 1}.length == 0
        return pos if found_marker
      end
    end

    # Helpers
    def parse_input(input)
      input
    end
  end
end
