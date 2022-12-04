module Year2022
  class Day04
    def part1(input)
      input = parse_input(input)
      fully_contains = 0
      input.each do |pair|
        if fully_contains?(pair)
          fully_contains += 1
        end
      end
      return fully_contains
    end

    def part2(input)
      input = parse_input(input)
      overlapping = 0
      input.each do |pair|
        if overlapping?(pair)
          overlapping += 1
        end
      end
      return overlapping
    end

    # Helpers
    def parse_input(input)
      input.split("\n").map do |pair|
        result = pair.match(/(\d+)-(\d+),(\d+)-(\d+)/)
        { elf1_start: result[1].to_i, elf1_end: result[2].to_i, elf2_start: result[3].to_i, elf2_end: result[4].to_i }
      end
    end

    def fully_contains?(pair)
      if (pair[:elf1_start] <= pair[:elf2_start] && pair[:elf1_end] >= pair[:elf2_end]) ||
        (pair[:elf1_start] >= pair[:elf2_start] && pair[:elf1_end] <= pair[:elf2_end])
        return true
      else
        return false
      end
    end

    def overlapping?(pair)
      return !(pair[:elf1_end] < pair[:elf2_start] || pair[:elf2_end] < pair[:elf1_start])
    end
  end
end
