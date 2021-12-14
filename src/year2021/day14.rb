module Year2021
  class Day14
    def part1(input)
      steps = 10

      template, rules = parse_input(input)
      counts = Hash.new(0)
      template.each{|char| counts[char] += 1}

      (0..steps-1).each do |step|
        template, counts = execute_insertion_rules(template, rules, counts)
        puts "step #{step.inspect}... #{template.inspect}"
      end

      minmax = counts.minmax_by{|char, count| count}

      return minmax[1][1] - minmax[0][1]
    end

    def part2(input)
      nil
    end

    # Helpers
    def parse_input(input)
      lines = input.split("\n")
      polymer_template = lines.shift.split("")
      pair_insertion_rules = {}

      lines.shift
      lines.each do |line|
        rule = line.split(" -> ")
        pair_insertion_rules[rule[0]] = rule[1]
      end

      return polymer_template, pair_insertion_rules
    end

    def execute_insertion_rules(template, rules, counts)
      result_template = template.dup

      template.each_with_index do |element, index|
        next if index == 0
        this_pair = "#{template[index-1]}#{element}"
        next if !rules.has_key?(this_pair)
        insert_at = 0 - (template.size - index + 1)
        result_template.insert(insert_at, rules[this_pair])
        counts[rules[this_pair]] += 1
      end

      return result_template, counts
    end
  end
end
