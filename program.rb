require 'pry'

# puts "Please enter the name of the file you wish to scan"
# filename = gets.strip

# file = File.open(filename, "r")

file = File.open("example.txt", "r")
original_text = file.read

text = original_text.downcase.gsub(/[^a-z0-9\s]/i, '')
words = text.split(' ')

binding.pry