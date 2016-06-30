require 'pry'
require_relative 'repeating_letters_logic'

puts "This program will identify the word in your text file"
puts "with the most frequently repeated letter"

# This method prompts the user for a text file path
# and allows them to proceed only once a valid file is
# successfully opened
filename = get_file_name

if filename
  # If a file object is present, run program logic
  run_repeating_letters(filename)
end