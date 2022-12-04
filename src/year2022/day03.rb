module Year2022
  class Day03
    def part1(input)
      input = parse_input(input)
      errors = input.map do |items|
        middle = items.length/2
        find_dup_in_string(items[0..middle-1], items[middle..-1])
      end
      return errors.map{|item_type| get_priority_of(item_type)}.sum
    end

    def part2(input)
      nil
    end

    # Helpers
    def parse_input(input)
      input.split("\n")
    end

    def find_dup_in_string(section1, section2)
      section2.each_char do |item|
        if section1.include?(item)
          return item
        end
      end
    end

    def get_priority_of(item_type)
      # Lowercase item types a through z have priorities 1 through 26.
      # Uppercase item types A through Z have priorities 27 through 52.
      mapping = ('a'..'z').zip(1..26).concat(('A'..'Z').zip(27..52)).to_h
      return mapping[item_type]
    end
  end
end
