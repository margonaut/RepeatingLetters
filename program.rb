require 'pry'

# puts "Please enter the name of the file you wish to scan"
# filename = gets.strip

text_file = File.open("example.txt", "r")
contents = text_file.read

binding.pry