require 'pry'
require_relative 'repeating_letters_logic'

puts "This program will identify the word in your text file"
puts "with the most frequently repeated letter"

# This method prompts the user for a text file path
# and allows them to proceed only once a valid file is
# successfully opened
file = open_file(get_file_name)

if file
  # If a file object is present, retrieve the text
  # then return the winning word
  text = read_text_from_file(file)
  get_winning_word(text)
end

# Add unit tests -> helps identify errors, edge cases