
# Users will be prompted for a file path when the program starts
def get_file_name
  puts "Enter the path of the .txt file you wish to scan"
  
  # Grab the filepath from user input, and strip it to make
  # sure we're getting only the string and not any newline characters
  # $stdin used for convinient test stubbing
  filename = $stdin.gets.chomp
  
  # Our program is looking for a text file. We can do a quick file
  # extension formatting check before letting the user move on
  until filename.end_with?(".txt")
    puts "Enter a file path ending with .txt"
    filename = get_file_name
  end
  filename
end

def run_repeating_letters(filename)
  # we'll only maintain the single word in the winning position
  winning_word = nil
  # the score to beat starts off at 1 because we're looking for duplicate
  # character counts of at least 2
  winning_score = 1
  
  # we should wrap our file opener in an error handler to catch
  # bad paths and exit the program gracefully
  begin
    File.open(filename, 'r') do |file|
      # let's process the text as we load each line of the file
      # this way we don't have to persist potentially huge collections of data
      # for use elsewhere
      file.each_line do |line|
        # we're going to break down our file by line, then by word
        line.split(' ').each do |word|
          # if the winning_score is greater than our word length, we know it
          # has no chance of being the new winner and can move on
          next if winning_score > word.length
          # each word is assigned a score, which has to beat
          # the current winning_score (not just match it) to become the
          # new winning_word
          score = score_word(word)
          # new winning_words and scores overwrite the old values
          if score > winning_score
            winning_word = word
            winning_score = score
          end
        end
      end
    end
    if winning_word
      # output the winning_word for terminal readability
      puts winning_word
      # return the value for testing
      winning_word
    else
      # If we end up here, the file contained no viable content
      puts "Your file contains no valid words."
    end
  rescue Errno::ENOENT => e
    puts "No such file."
  end
end

def score_word(word)
  # First we're going to strip out extra characters so we only
  # generate a frequency check on letters that matter 
  
  # Then we split up our word into an array of characters so
  # we can use emuberables methods that are unavailable to strings
  letters = word.downcase.gsub(/[^a-z0-9\s]/i, '').split('')
    
  # We're going to pass a new Hash with a default value of zero
  # into .each_with_object, which will iterate over our letters array
  # and return a hash containing a character frequency count
  letter_frequency = letters.each_with_object(Hash.new(0)) { |letter, count| count[letter] += 1 }
  
  # The maximum value in our new letter_frequency array will be used
  # as our word score - we don't care about the character, just
  # how many times it repeats. If our word didn't have any viable characters
  # the letter_frequency variable wont have a value. We would
  # pass along a zero instead
  letter_frequency.empty? ? 0 : letter_frequency.max_by(&:last)[1]
end