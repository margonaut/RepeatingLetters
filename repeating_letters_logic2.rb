# Users will be prompted for a file path when the program starts
def get_file_name
  puts "Enter the path of the .txt file you wish to scan"
  
  # Grab the filepath from user input, and strip it to make
  # sure we're getting only the string and not any newline characters
  # $stdin used for convinient test stubbing
  filename = $stdin.gets.chomp
  
  # Our program is looking for a text file. We can perform a first
  # basic check by making sure the given path ends with the
  # correct file extension
  until filename.end_with?(".txt")
    puts "Enter a file path ending with .txt"
    filename = get_file_name
  end
  filename
end

def run_repeating_letters(filename)
  # The main program behavior is separated from terminal input 
  # interaction in this wrapper method for convinient use in 
  # benchmarking and some areas of the test suite
  file = open_file(filename)
  text = read_text_from_file(file)
  get_winning_word(text)
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
  
  # Return the original text for now since we want to maintain formatting
  # for our final output
  text
end

def get_winning_word(text)
  # We're only going to maintain the word in the winning position
  # along with the corresponding score
  winning_word = nil
  winning_score = 0
  
  # Break the text down into individual words
  words = text.split(' ')
  
  # Sort by the length of the word with extra characters removed, longest first.
  words = words.reverse.sort_by{ |a| a.gsub(/[^a-z\s]/i, '').length }.reverse

    words_and_lengths = words.map{|w|score_word(w)}.reduce Hash.new, :merge
    max = words_and_lengths.keys.max
    winning_word = words_and_lengths[max]
    winning_score = max
  
  # If our text file ends up containing no words with repeating letters,
  # the default winning_word will never be overwritten
  if winning_word
    # Simply returning the winning string instead of descriptive text 
    # will make integration into our test suite easier. An optional terminal output
    # is included here for human readability
    # puts winning_word
    winning_word
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
  {score:word}
end

