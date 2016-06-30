# This file was used for iterative comparison benchmarking.
# Some of my last tweaks can be found in the get_winning_word
# method, but I decided that the unreliable performance gain wasn't worth
# the muddied, less readable code

require 'pry'

def run_repeating_letters2(filename)
  # open file
  file = open_file(filename)
  # retreive text content from file
  text = read_text_from_file(file)
  # retreive winning word from text content
  get_winning_word(text)
end

def get_file_name
  puts "Enter the path of the .txt file you wish to scan"
  
  # Grab the filepath from user input, and strip it to make
  # sure we're getting only the string and not any newline characters
  filename = $stdin.gets.chomp
  
  # Our program is looking for a text file. We can perform a first
  # basic check by making sure the given path ends with the
  # correct file extension
  until filename.end_with?(".txt")
    puts "Entering a file path ending with .txt"
    filename = get_file_name
  end
  filename
end

def open_file(filename)
  # We want to return a File object if the given path leads to an
  # existing file. If not, we catch the error and exit the program
  begin
    file = File.open(filename, "r")
  rescue Errno::ENOENT => e
    puts "No such file."
  end
end

def read_text_from_file(file)
  # First, extract the text from our file object
  text = file.read
  
  # strip the text down to usable characters only
  stripped_text = text.downcase.gsub(/[^a-z0-9\s]/i, '')
  # and check to make sure this text contains at least two
  # viable characters before proceeding. Text with a single
  # character could contain no duplicates and does not
  # meet our criteria
  unless stripped_text.length >= 2
    abort("Invalid content")
  end
  
  # Return the original text since we want to maintain formatting
  # for our final output
  text
end

def get_winning_word(text)
  # Break the text down into individual words
  
  stripped_words = text.downcase.gsub(/[^a-z\s]/i, '').split(' ')
  words = stripped_words.reverse.sort_by{ |a| a.length }.reverse
  
  
  # We're only going to maintain the word in the winning position
  # along with the corresponding score
  winning_word = nil
  winning_score = 0
  
  words.each do |word|
    # We can greatly reduce the runtime at scale by eliminating a big chunk
    # of short words. Because we maintain the winning score and have sorted
    # our words array by length, we know that the winning score will be
    # impossible to beat once we reach words with less letters than that score
    if word.length > winning_score
      # We want to keep the original text handy for our final output,
      # but we'll need to score our words based on a version cleaned up with
      # a regex pattern.
      # stripped_word = word.downcase.gsub(/[^a-z\s]/i, '')
      
      # Let's make sure there are repeated characters
      # present in our word before we continue. Otherwise,
      # our program will move on to the next word
      if has_repeated_letters?(word)
        
        # now that we know we're working with a word
        # that contains repeated letters, let's evaluate it for
        # a score - the highest number of times a letter is repeated
        score = score_word(word)
        
        # Compare this score with that of the current winning word.
        # Since the first word with the highest score is the one
        # we want to return, we'll only replace our winning_word
        # if we have a score that is greater, not just equal to
        # the current winner
        if score > winning_score
          winning_score = score
          winning_word = word
        end
      end  
    end
  end
  
  
  # If our text file ends up containing no words with repeating letters,
  # the default winning_word will never be overwritten
  if winning_word
    # Simply returning the winning string instead of descriptive text 
    # will make integration into our test suite easier. A terminal output
    # is included here for human readability
    original_words = text.split().find_all{ |w| w.length >= winning_score}
    original_word = original_words.find{ |w| w.downcase.gsub(/[^a-z\s]/i, '') == winning_word }
    puts original_word
    original_word
    
  else
    # If a winning_word does not exist, we know we have not found
    # any words with repeating letters in the given text
    puts "No repeating letters."
  end
end

def has_repeated_letters?(word)
  # If a string's length is not equal to the count of unique
  # characters it contains, we know it contains at least one
  # instance of a duplicate letter
  word.length != word.split('').uniq.length
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
  score = letter_frequency.max_by { |k,v| v }[1]
end
