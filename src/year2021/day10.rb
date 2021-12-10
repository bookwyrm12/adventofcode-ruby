module Year2021
  class Day10
    def part1(input)
      input = parse_input(input)

      syntax_error_score = 0
      input.each do |row|
        status, invalid_char = parse_line(row)
        syntax_error_score += syntax_scores[invalid_char.to_sym] if status == :corrupted
      end

      syntax_error_score
    end

    def part2(input)
      nil
    end

    # Helpers
    def parse_input(input)
      input.split("\n")
    end

    def parse_line(line)
      char_map = {')': '(', ']': '[', '}': '{', '>': '<'}
      push_chars = ['(', '[', '{', '<']
      pop_chars = [')', ']', '}', '>']
      line_stack = []
      line.each_char do |char|
        if push_chars.include?(char)
          line_stack.push(char)
        else #if pop_chars.include?(char)
          matching_char = line_stack.pop
          return :corrupted, char if matching_char != char_map[char.to_sym]
        end
      end

      return :incomplete, nil if line_stack.size > 0
      return :success, nil
    end

    def syntax_scores
      {
        ')': 3,
        ']': 57,
        '}': 1197,
        '>': 25137,
      }
    end
  end
end
