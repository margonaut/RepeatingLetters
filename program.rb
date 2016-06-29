# First, extract the test from the file
def read_from_file(filename)
  file = File.open(filename, "r")
  original_text = file.read
  text = original_text.downcase.gsub(/[^a-z0-9\s]/i, '')
  
  # stop the program if the file is blank or full of unusable characters
  unless text.length > 0
    abort("This file contains no suitable text")
  end
  
  text
end

def find_winning_word(text)
  analyzed_words = analyze_words(text)
  winning_word = analyzed_words.max_by {|k, v| v[1] }
  puts "The winning word is \"#{winning_word[0]}\""
  puts "The letter #{winning_word[1][0]} is repeated #{winning_word[1][1]} times."
end

def analyze_words(text)
  words = text.split(' ')
  results = {}
  words.each do |word|
    results[word] = most_repeated_letter(word)
  end
  results
end

def most_repeated_letter(word)
  letters = letter_count(word)
  most_repeated_letter = letters.max_by { |k, v| v }
end

def letter_count(word)
  results = Hash.new(0)
  letters = word.split("")
  letters.each do |letter|
    results[letter] += 1
  end
  results
end

# User Interaction

puts "This program will identify the word in your text file"
puts "with the most frequently repeated letter"
puts "Please enter the name or path of the file you wish to scan."
puts "For example, 'example.txt'"

filename = gets.strip

until filename.include?(".txt")
  puts "Please make sure you are entering a file name or path ending with .txt"
  filename = gets.strip
end

begin
  text = read_from_file(filename)
  find_winning_word(text)
rescue Errno::ENOENT => e
  puts "No such file, please try again."
end


# Things to improve next time

# Add unit tests -> helps identify errors, edge cases
# Putting logic code into separate file
# Check for explicitly specified return value format
# Improve regular expressions , roll your own
# Documentation, code comments