require 'pry'
require_relative 'repeating_letters_logic'

puts "This program will identify the word in your text file"
puts "with the most frequently repeated letter"

# Prompt the user for a valid text file path
filename = get_file_name

if filename
  run_repeating_letters(filename)
end