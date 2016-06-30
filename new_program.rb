require 'pry'

def get_file
  puts "Please enter the name or path of the file you wish to scan."
  puts "For example, 'example.txt'"
  
  # Grab the filepath from user input, and strip it to make
  # sure we're getting only the string and not the /n enter character
  filename = gets.strip
  
  # Our program is looking for a text file. We can perform a first
  # basic check by making sure the given path ends with the
  # correct file extension
  until filename.end_with?(".txt")
    puts "Please make sure you are entering a file name or path ending with .txt"
    filename = gets.strip
  end
  
  begin
    file = File.open(filename, "r")
  rescue Errno::ENOENT => e
    puts "No such file, please try again."
  end
end

def read_text_from_file(file)
  # First extract the text from the file
  text = file.read
  
  # strip the text down to usable characters only
  stripped_text = text.downcase.gsub(/[^a-z0-9\s]/i, '')
  # and check to make sure the file contains viable content
  # before proceeding, abort if not
  unless stripped_text.length > 0
    abort("This file contains no suitable text")
  end
  
  # Return the original text since we want to maintain formatting
  # for our final output
  text
end

def score_word(word)
  # Split up our word into an array of characters so
  # we can use emuberables methods that are unavailable to strings
  letters = word.split('')
  
  # We're going to pass a new Hash with a default value of zero
  # into .each_with_object, which will iterate over our letters array
  # and return a hash containing a character frequency count
  letter_frequency = letters.each_with_object(Hash.new(0)) { |letter, count| count[letter] += 1 }
  
  # The maximum value in our new letter_frequency array will be used
  # as our word score - we don't care about the character, just
  # how many times it repeats
  score = letter_frequency.max_by { |k, v| v }[1]
end

def has_repeated_letters?(word)
  # If a string's length is not equal to the count of unique
  # characters it contains, we know it contains at least one
  # instance of a duplicate letter
  word.length != word.split('').uniq.length
end

def get_winning_word(text)
  # Break the text down into individual words
  words = text.split(' ')
  
  # We're only going to maintain the word in the first position
  # along with its score
  # An example winning word: {text: "aaagh", score: 3}
  winning_word = { text: '', score: 0}
  
  words.each do |word|
    # We want to keep the original text handy for our final output,
    # so we'll strip extraneous characters out case by case using
    # a regex pattern written to replace them with nothing
    stripped_word = word.downcase.gsub(/[^a-z0-9\s]/i, '')
    
    # Let's make sure there are repeated characters
    # present in our word before we continue. Otherwise,
    # our program will move on to the next word
    if has_repeated_letters?(stripped_word)
      
      # now that we know we're working with a word
      # that contains repeated letters, let's evaluate it for
      # a score - the highest number of times a letter is repeated
      score = score_word(stripped_word)
      
      # Compare this score with that of the current winning word.
      # Since the first word with the highest score is the one
      # we want to return, we'll only replace our winning_word
      # if we have a score that is greater, not just equal to our current
      if score > winning_word[:score]
        winning_word = { text: word, score: score }
      end
    end  
  end
  
  # We'll simply return the winning string
  # This will make integration into our test suite easier
  
  # what if no viable words
  if winning_word[:score] > 0
    puts winning_word[:text]
  else
    puts "This text does not contain a word with repeating letters"
  end
end

# User Interaction

puts "This program will identify the word in your text file"
puts "with the most frequently repeated letter"

  file = get_file
  
  if file
    text = read_text_from_file(file)
    get_winning_word(text)
  end


# Things to improve next time

# Add unit tests -> helps identify errors, edge cases
# Putting logic code into separate file
# Check for explicitly specified return value format
# Improve regular expressions , roll your own
# Documentation, code comments