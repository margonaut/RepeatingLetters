require 'pry'

# puts "Please enter the name of the file you wish to scan"
# filename = gets.strip

# file = File.open(filename, "r")

file = File.open("example.txt", "r")
original_text = file.read

text = original_text.downcase.gsub(/[^a-z0-9\s]/i, '')


def letter_count(word)
  results = Hash.new(0)
  letters = word.split("")
  letters.each do |letter|
    results[letter] += 1
  end
  results
end


def sentence_analyzer(text)
  words = text.split(' ')
  words_with_highest_letter = {}
  
  words.each do |word|
    letters = letter_count(word)
    highest_letter = letters.max_by { |k, v| v }
    words_with_highest_letter[word] = highest_letter
  end
  
  winning_word = words_with_highest_letter.max_by {|k, v| v[1] }
  
  puts "The winning word is \"#{winning_word[0]},\" with the letter #{winning_word[1][0]} repeated #{winning_word[1][1]} times."
end

sentence_analyzer(text)



# what if the file doesn't exist
# what if it doesn't have txt extension
# what if a word has multiple letters repeated equal #s of times