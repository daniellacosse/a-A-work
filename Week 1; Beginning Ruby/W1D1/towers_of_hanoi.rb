#!/usr/bin/env ruby

def check_towers (towers)
  remove_command = 0
  addition_command = 0
  p "This is tower1: #{towers[0]}"
  p "This is tower2: #{towers[1]}"
  p "This is tower3: #{towers[2]}"

    print "Those are the towers. Type the tower (integer) you want to take the top disc from:\n"
    remove_command = gets.chomp.to_i
    if remove_command > 3 || remove_command < 0
      print "Bad move buddy.\n"
      check_towers(towers)
    elsif towers[remove_command - 1].empty?
      print "Bad move buddy.\n"
      check_towers(towers)
    end

    print "Which tower (integer) do you want to add the disc to?\n"
    addition_command = gets.chomp.to_i
    if addition_command > 3 || addition_command < 0
      print "Bad move buddy.\n"
      check_towers(towers)
    elsif towers[addition_command - 1].last.to_i < towers[remove_command -1].last
      if !towers[addition_command-1].empty?
        print "Bad move buddy.\n"
        check_towers(towers)
      end
    end

  [remove_command, addition_command]

end

def modify_towers(command_arr,towers)
  towers[command_arr[1]-1] << towers[command_arr[0]-1].pop
  towers
end


if __FILE__ == $PROGRAM_NAME
  towers = [[4,3,2,1],[],[]]

  until towers == [[],[],[4,3,2,1]] do
    command = check_towers(towers)
    towers = modify_towers(command,towers)
  end

  print "You won!!!!"

end
