def guessing_game
  number_to_guess = (1..100).to_a.sample
  guesses = 0
  guess = 0

  loop do
    puts "What's your guess?"
    guess = gets.to_i
    guesses += 1

    if number_to_guess == guess
      puts "You won, you guessed #{guesses} time(s)."
      break
    elsif number_to_guess > guess
      puts "Too low!"
    else
      puts "Too high!"
    end
  end
end

def shuffler
  puts "What file do you want to shuffle?"
  file_name = gets.chomp

  lines_to_shuffle = File.readlines(file_name)
  lines_to_shuffle.shuffle!

  File.open("#{file_name}-shuffled.txt", "w") do |file|
    file.puts lines_to_shuffle
  end
end

class RPN
  attr_accessor :cmd_array

  def initialize
    @cmd_array = []
    @commands = ["+", "-", "*", "/"]

    @cmd_array = File.read(ARGV.pop).chomp.split(" ") unless ARGV.empty?
  end

  def take_command
    command = gets.chomp

    if @commands.include?(command)
      push_command(command)
      "Operator pushed."
    elsif command.to_i > 0
      push_command(command)
      "Number pushed."
    elsif command == "eval"
      answer = evaluate
      "The answer is #{answer}."
    elsif command == "clear"
      @cmd_array = []
      "Calculator cleared."
    elsif command == "exit"
      "Done."
    else
      "Invalid command!"
    end
  end

  def run
    arg = ""

    if @cmd_array != []
      puts "File loaded."
    end

    until arg == "Exit"
      puts "Stored commands: #{@cmd_array}"
      arg = take_command
    end
  end

  def push_command(command)
    @cmd_array << command
  end

  def evaluate
    until @cmd_array.length == 1
      @cmd_array.each_index do |index|

        if @commands.include?(@cmd_array[index])
          operator = @cmd_array[index].to_sym
          first_num = @cmd_array[index - 2].to_i
          second_num = @cmd_array[index - 1].to_i

          @cmd_array[index-2..index] = first_num.send(operator, second_num)
          break
        end

      end
    end

    @cmd_array[0]
  end # eval end
end # class end

#!usr/bin/env ruby

if __FILE__ == $PROGRAM_NAME
  test_rpn = RPN.new
  test_rpn.run
end