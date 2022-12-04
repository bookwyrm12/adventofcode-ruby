module Year2022
  class Day02
    def part1(input)
      input = parse_input(input)
      return input.map{|round| get_shape_score(round[1]) + get_outcome_score(round[0], round[1])}.sum
    end

    def part2(input)
      nil
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
        'X' => 1,
        'Y' => 2,
        'Z' => 3,
      }
      return play_map[you]
    end

    def get_outcome_score(opponent, you)
      # 0 pts if you lose
      # 3 pts for draw
      # 6 pts if you win
      play_map = {
        'A' => {
          'X' => 3,
          'Y' => 6,
          'Z' => 0,
        },
        'B' => {
          'X' => 0,
          'Y' => 3,
          'Z' => 6,
        },
        'C' => {
          'X' => 6,
          'Y' => 0,
          'Z' => 3,
        }
      }
      return play_map[opponent][you]
    end
  end
end
