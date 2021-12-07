module Year2021
  class Day02
    def part1(input)
      input = parse_input(input)
      
      horizontal_forward = sum_of_instructions(input, 'forward')
      depth_down = sum_of_instructions(input, 'down')
      depth_up = sum_of_instructions(input, 'up')
      
      horizontal_pos = 0 + horizontal_forward
      depth_pos = 0 + depth_down - depth_up

      horizontal_pos * depth_pos
    end

    def part2(input)
      instructions = parse_input(input)
      horizontal = depth = aim = 0

      instructions.each do |direction, amt|
        case direction
        when 'forward'
          horizontal = horizontal + amt
          depth = depth + (aim * amt)
        when 'down'
          aim = aim + amt
        when 'up'
          aim = aim - amt
        end
      end

      horizontal * depth
    end

    # Helpers
    def parse_input(input)
      input.split("\n").map do |instruction|
        instruction_arr = instruction.split(' ')
        [instruction_arr[0], instruction_arr[1].to_i]
      end
    end

    def sum_of_instructions(input, direction)
      input.select{|inst| inst[0] == direction}.map{|inst| inst[1]}.reduce(:+)
    end
  end
end
