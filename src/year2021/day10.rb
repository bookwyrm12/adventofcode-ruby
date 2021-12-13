module Year2021
  class Day10
    CHAR_MAP = {')': '(', ']': '[', '}': '{', '>': '<', '(': ')', '[': ']', '{': '}', '<': '>'}
    PUSH_CHARS = ['(', '[', '{', '<']
    POP_CHARS = [')', ']', '}', '>']
    ILLEGAL_CHAR_SCORES = {
      ')': 3,
      ']': 57,
      '}': 1197,
      '>': 25137,
    }
    AUTOCOMPLETE_CHAR_SCORES = {
      ')': 1,
      ']': 2,
      '}': 3,
      '>': 4,
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
      input = parse_input(input)

      completion_scores = []
      input.each do |row|
        status, line_stack = parse_line(row)
        next if status != :incomplete
        completion_scores.push(autocomplete_line(line_stack))
      end

      completion_scores.sort[completion_scores.size.div(2)]
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

      return :incomplete, line_stack if line_stack.size > 0
      return :success
    end

    def autocomplete_line(line_stack)
      score = 0
      line_stack.reverse.each do |char|
        closing_char = CHAR_MAP[char.to_sym]
        score = (score * 5) + AUTOCOMPLETE_CHAR_SCORES[closing_char.to_sym]
      end
      score
    end
  end
end
