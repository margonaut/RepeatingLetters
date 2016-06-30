# First, extract the test from the file
def read_from_file(filename)
  file = File.open(filename, "r")
  text = file.read
  stripped_text = text.downcase.gsub(/[^a-z0-9\s]/i, '')
  
  # stop the program if the file is blank or full of unusable characters
  unless stripped_text.length > 0
    abort("This file contains no suitable text")
  end
  
  text
end

# def find_winning_word(text)
#   analyzed_words = analyze_words(text)
#   winning_word = analyzed_words.max_by {|k, v| v[1] }
#   puts "The winning word is \"#{winning_word[0]}\""
#   puts "The letter #{winning_word[1][0]} is repeated #{winning_word[1][1]} times."
# end
# 
# def analyze_words(text)
#   words = text.split(' ')
#   results = {}
#   words.each do |word|
#     results[word] = most_repeated_letter(word)
#   end
#   results
# end
# 
# def most_repeated_letter(word)
#   letters = letter_count(word)
#   most_repeated_letter = letters.max_by { |k, v| v }
# end
# 
# def letter_count(word)
#   results = Hash.new(0)
#   letters = word.split("")
#   letters.each do |letter|
#     results[letter] += 1
#   end
#   results
# end

def get_file
  puts "Please enter the name or path of the file you wish to scan."
  puts "For example, 'example.txt'"
  
  # Grab the filepath from user input, and strip it to make
  # sure we're getting only the string and not the /n enter character
  filename = gets.strip
  
  # Our program is looking for a text file. We can perform a First
  # basic check by making sure the correct file extension is included,
  # and prompt for input again if not
  until filename.include?(".txt")
    puts "Please make sure you are entering a file name or path ending with .txt"
    filename = gets.strip
  end
  
  filename
end

def score_word(word)
  binding.pry
  return score
end

def has_repeated_letters?(word)
  word.length != word.strip('').uniq.length
end

def get_winning_word(text)
  # Break the text down into individual words
  words = text.split(' ')
  
  # We're only going to maintain the word in the first position
  # along with its score
  winning_word = null
  #example: {text: "aaagh", score: 3}
  
  words.each do |word|
    # We want to keep the original text handy for our final output,
    # so we'll strip extraneous characters out case by case
    # using a regex written to replace these characters with spaces
    stripped_word = word.downcase.gsub(/[^a-z0-9\s]/i, '')
    
    # Let's make sure there are repeated characters
    # in our word before we continue
    binding.pry
    if has_repeated_letters?(stripped_word)
      # get score, return integer
      score = score_word(stripped_word)
      # Compare our score to 
      if score > winning_word[:score]
        winning_word = { text: word, score: score }
      end
    end  
  end
  
  # We'll simply return the winning string
  # This will make integration into our test suite easier
  winning_word[:text]
end

# User Interaction

puts "This program will identify the word in your text file"
puts "with the most frequently repeated letter"

filename = get_file

begin
  text = read_from_file(filename)
  get_winning_word(text)
rescue Errno::ENOENT => e
  puts "No such file, please try again."
end


# Things to improve next time

# Add unit tests -> helps identify errors, edge cases
# Putting logic code into separate file
# Check for explicitly specified return value format
# Improve regular expressions , roll your own
# Documentation, code comments