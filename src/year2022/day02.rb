module Year2022
  class Day02
    def part1(input)
      input = parse_input(input)
      scores = input.map do |round|
        your_response = map_instruction_to_response(round[1])
        get_shape_score(your_response) + get_outcome_score(round[0], your_response)
      end
      return scores.sum
    end

    def part2(input)
      input = parse_input(input)
      scores = input.map do |round|
        your_response = get_response(round[0], round[1])
        get_shape_score(your_response) + get_outcome_score(round[0], your_response)
      end
      return scores.sum
    end

    # Helpers
    def parse_input(input)
      input.split("\n").map{|x| x.split(" ")}
    end

    def get_shape_score(you)
      # 1 pts for rock
      # 2 pts for paper
      # 3 pts for scissors
      play_map = {
        :rock => 1,
        :paper => 2,
        :scissors => 3,
      }
      return play_map[you]
    end

    def map_instruction_to_response(instruction)
      return {
        'X' => :rock,
        'Y' => :paper,
        'Z' => :scissors,
      }[instruction]
    end

    def get_outcome_score(opponent, you)
      # 0 pts if you lose
      # 3 pts for draw
      # 6 pts if you win
      play_map = {
        'A' => {
          :rock => 3,
          :paper => 6,
          :scissors => 0,
        },
        'B' => {
          :rock => 0,
          :paper => 3,
          :scissors => 6,
        },
        'C' => {
          :rock => 6,
          :paper => 0,
          :scissors => 3,
        }
      }
      return play_map[opponent][you]
    end

    def get_response(opponent, result)
      # X = lose
      # Y = draw
      # Z = win
      play_map = {
        'A' => {
          'X' => :scissors,
          'Y' => :rock,
          'Z' => :paper,
        },
        'B' => {
          'X' => :rock,
          'Y' => :paper,
          'Z' => :scissors,
        },
        'C' => {
          'X' => :paper,
          'Y' => :scissors,
          'Z' => :rock,
        }
      }
      return play_map[opponent][result]
    end
  end
end
