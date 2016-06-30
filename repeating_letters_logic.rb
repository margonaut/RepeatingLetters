require 'pry'
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
  winning_word = nil
  winning_score = 1
  
  begin
    File.open(filename, 'r') do |file|
      # let's process the text as we load each line
      # this way we don't have to persist potentially huge collections of data
      # for use elsewhere
      file.each_line do |line|
        line.split(' ').each do |word|
          # if the winning_score is greater than our word length, we know it
          # has no chance of being the new winner, and move on
          next if winning_score > word.length
          score = score_word(word)
          if score > winning_score
            winning_word = word
            winning_score = score
          end
        end
      end
    end
    if winning_word
      puts winning_word
      winning_word
    else
      puts "Your file contains no valid words."
    end
  rescue Errno::ENOENT => e
    puts "No such file."
  end
end


# def read_text_from_file(file)
#   # First, extract the text from our file object
#   text = file.read
#   File.open(filename, "r") do |f|
#   
#   # strip the text down to usable characters only
#   stripped_text = text.downcase.gsub(/[^a-z0-9\s]/i, '')
#   # and check to make sure this text contains at least two
#   # viable characters before proceeding. Text with a single
#   # character could contain no duplicates and does not
#   # meet our criteria
#   unless stripped_text.length >= 2
#     abort("Invalid content")
#   end
#   # Return the original text for now since we want to maintain formatting
#   # for our final output
#   text
# end

def has_repeated_letters?(word)
  # If a string's length is not equal to the count of unique
  # characters it contains, we know it contains at least one
  # instance of a duplicate letter
  word.length != word.split('').uniq.length
end

def score_word(word)
  # Split up our word into an array of characters so
  # we can use emuberables methods that are unavailable to strings
  letters = word.downcase.gsub(/[^a-z0-9\s]/i, '').split('')
    
  # We're going to pass a new Hash with a default value of zero
  # into .each_with_object, which will iterate over our letters array
  # and return a hash containing a character frequency count
  letter_frequency = letters.each_with_object(Hash.new(0)) { |letter, count| count[letter] += 1 }
  
  # The maximum value in our new letter_frequency array will be used
  # as our word score - we don't care about the character, just
  # how many times it repeats
  score = letter_frequency.max_by { |k,v| v }[1]
end

# empty file
# too short
# ties
# no such file