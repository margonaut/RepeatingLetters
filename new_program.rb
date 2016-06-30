require 'pry'
require_relative 'program_logic'


puts "This program will identify the word in your text file"
puts "with the most frequently repeated letter"

# This method prompts the user for a text file path
# and allows them to proceed only once a valid file is
# successfully opened
file = get_file

if file
  # If a file object is present, retrieve the text
  # then return the winning word
  text = read_text_from_file(file)
  get_winning_word(text)
end


# Things to improve next time

# Add unit tests -> helps identify errors, edge cases
# Putting logic code into separate file
# Check for explicitly specified return value format
# Improve regular expressions , roll your own
# Documentation, code comments