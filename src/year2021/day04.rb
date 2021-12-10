module Year2021
  class Day04
    def part1(input)
      drawn_numbers, boards = parse_input(input)
      winning_board, last_number_called = play_bingo(drawn_numbers, boards)
      winning_board.unmarked_numbers.sum * last_number_called
    end

    def part2(input)
      drawn_numbers, boards = parse_input(input)
      last_winning_board, last_number_called = play_bingo_to_lose(drawn_numbers, boards)
      last_winning_board.unmarked_numbers.sum * last_number_called
    end

    # Helpers
    def parse_input(input)
      input = input.split("\n")
      drawn_numbers = input.shift.split(",").map(&:to_i)
      boards = []
      this_board = []
      this_board_id = 1

      input.each_with_index do |line, index|
        this_board.push(line.split.map(&:to_i)) if line != ""

        if this_board.size == 5
          boards.push(BingoBoard.new(this_board_id, this_board))
          this_board = []
          this_board_id += 1
        end
      end

      return drawn_numbers, boards
    end

    def play_bingo(drawn_numbers, boards)
      puts "let's play bingo!"
      drawn_numbers.each do |number_called|
        puts "caller: number #{number_called.inspect}"
        winning_board = draw_number(boards, number_called)
        return winning_board, number_called if winning_board
      end
    end

    def play_bingo_to_lose(drawn_numbers, boards)
      puts "let's play bingo (to lose)!"
      remaining_boards = boards.dup
      drawn_numbers.each do |number_called|
        puts "caller: number #{number_called.inspect}"
        draw_number(remaining_boards, number_called, false)
        winning_boards = check_winning_boards(remaining_boards)
        remaining_boards -= winning_boards if winning_boards
        puts "after draw_number: remaining_boards (#{remaining_boards.size.inspect}): #{remaining_boards.map(&:id)}"
        remaining_boards.each {|b| b.print_board}
        return winning_boards.first, number_called if remaining_boards.empty?
      end
    end

    def draw_number(boards, number_called, stop_if_win=true)
      boards.each do |b|
        b.mark_number(number_called)
        return b if stop_if_win && b.wins?
      end
      return
    end

    def check_winning_boards(boards)
      winning_boards = []
      boards.each do |b|
        winning_boards.push(b) if b.wins?
      end
      winning_boards
    end
  end
end

class BingoBoard
  attr_reader :id, :unmarked_numbers

  def initialize(board_id, board)
    @id = board_id
    @unmarked_numbers = board.flatten

    @board = []
    @board_cols = [[], [], [], [], []]
    @squares = {}
    board.each_with_index do |row, row_index|
      row_squares = []
      row.each_with_index do |value, col_index|
        @squares[value] = BingoSquare.new(value, row_index, col_index)
        row_squares.push(@squares[value])
        @board_cols[col_index].push(@squares[value])
      end
      @board.push(row_squares) if row_squares.size > 0
    end
  end

  def mark_number(number)
    return if !@unmarked_numbers.include?(number)
    @squares[number].mark
    @unmarked_numbers.delete(number)
  end

  def wins?
    return wins_by_row? || wins_by_col?
  end

  def print_board
    @board.each do |row|
      row_arr = []
      row.each do |square|
        row_arr.push(square.marked ? "X" : square.value)
      end
      puts row_arr.join("\t")
    end
    puts "- - - - -"
  end

  private

  def wins_by_row?
    @board.each do |row|
      return true if row_or_col_all_marked?(row)
    end
    return false
  end

  def wins_by_col?
    @board_cols.each do |col|
      return true if row_or_col_all_marked?(col)
    end
    return false
  end

  def row_or_col_all_marked?(row_or_col)
    row_or_col.each do |square|
      return false if !square.marked
    end
    return true
  end
end

class BingoSquare
  attr_reader :marked, :row, :col, :value

  def initialize(value, row, col)
    @value = value
    @row = row
    @col = col
    @marked = false
  end

  def mark
    @marked = true
  end
end
