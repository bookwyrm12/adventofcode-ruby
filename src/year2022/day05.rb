module Year2022
  class Day05
    def part1(input)
      stacks, instructions = parse_input(input)
      
      instructions.each do |instruction|
        move_crates(stacks, instruction)
      end

      result = []
      stacks.sort.each do |id, stack|
        result.push(stack.crates.last)
      end
      return result.join
    end

    def part2(input)
      stacks, instructions = parse_input(input)
      
      instructions.each do |instruction|
        move_multiple_crates(stacks, instruction)
      end

      result = []
      stacks.sort.each do |id, stack|
        result.push(stack.crates.last)
      end
      return result.join
    end

    # Helpers
    def parse_input(input)
      stacks = {}
      instructions = []

      drawing_lines, instructions_lines = input.split("\n\n")

      drawing_lines = drawing_lines.split("\n").reverse
      stack_ids = drawing_lines.shift.split
      
      # create stacks, with no crates in them yet
      stack_ids.each do |id|
        stacks[id.to_i] = CrateStack.new(id)
      end

      # build crate stacks from drawing
      drawing_lines.each do |line|
        line.chars.each_slice(4).to_a.each_with_index.map{|arr, i| [i+1, arr[1]]}.to_h.each do |id, crate|
          stacks[id].add_crate(crate) if !crate.strip.empty?
        end
      end
      
      # parse instruction lines
      instructions_lines.split("\n").each do |instruction_str|
        instructions.push(CrateRearrangementStep.new(instruction_str))
      end

      return stacks, instructions
    end

    def move_crates(stacks, instruction)
      (0..instruction.num_crates - 1).each do |i|
        stacks[instruction.to_stack].add_crate(stacks[instruction.from_stack].remove_crate)
      end
    end

    def move_multiple_crates(stacks, instruction)
      stacks[instruction.to_stack].add_multiple_crates(stacks[instruction.from_stack].remove_multiple_crates(instruction.num_crates))
    end
  end

  class CrateStack
    attr_accessor :id, :crates
    
    def initialize(stack_id, initial_crates = [])
      self.id = stack_id
      self.crates = initial_crates
    end

    def add_crate(crate)
      return self.crates.push(crate)
    end

    def remove_crate()
      return self.crates.pop
    end

    def add_multiple_crates(new_crates)
      return self.crates.push(new_crates).flatten!
    end

    def remove_multiple_crates(num_crates)
      return self.crates.pop(num_crates)
    end

    def flip_stack()
      self.crates = self.crates.reverse
      return self.crates
    end
  end

  class CrateRearrangementStep
    attr_accessor :from_stack, :to_stack, :num_crates
    
    def initialize(instruction)
      result = instruction.match(/move (\d+) from (\d+) to (\d+)/)
      self.num_crates = result[1].to_i
      self.from_stack = result[2].to_i
      self.to_stack = result[3].to_i
    end
  end
end
