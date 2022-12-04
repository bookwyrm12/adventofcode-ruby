module Year2022
  class Day01
    def part1(input)
      input = parse_input(input)

      return input.map{|x| x.sum}.max
    end

    def part2(input)
      nil
    end

    # Helpers
    def parse_input(input)
      input.split("\n\n").map{|x| x.split("\n").map(&:to_i)}
    end
  end
end
