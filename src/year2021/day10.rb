module Year2021
  class Day10
    CHAR_MAP = {')': '(', ']': '[', '}': '{', '>': '<'}
    PUSH_CHARS = ['(', '[', '{', '<']
    POP_CHARS = [')', ']', '}', '>']
    ILLEGAL_CHAR_SCORES = {
      ')': 3,
      ']': 57,
      '}': 1197,
      '>': 25137,
    }

    def part1(input)
      input = parse_input(input)

      syntax_error_score = 0
      input.each do |row|
        status, invalid_char = parse_line(row)
        syntax_error_score += ILLEGAL_CHAR_SCORES[invalid_char.to_sym] if status == :corrupted
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
      line_stack = []
      line.each_char do |char|
        if PUSH_CHARS.include?(char)
          line_stack.push(char)
        else #if POP_CHARS.include?(char)
          matching_char = line_stack.pop
          return :corrupted, char if matching_char != CHAR_MAP[char.to_sym]
        end
      end

      return :incomplete, nil if line_stack.size > 0
      return :success, nil
    end
  end
end
