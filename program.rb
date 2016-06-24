def letter_count(word)
  results = Hash.new(0)
  letters = word.split("")
  letters.each do |letter|
    results[letter] += 1
  end
  results
end

def most_repeated_letter(word)
  letters = letter_count(word)
  most_repeated_letter = letters.max_by { |k, v| v }
end

def analyze_words(text)
  words = text.split(' ')
  results = {}
  
  words.each do |word|
    results[word] = most_repeated_letter(word)
  end
  
  results
end

def sentence_analyzer(text)
  analyzed_words = analyze_words(text)
  winning_word = analyzed_words.max_by {|k, v| v[1] }
  puts "The winning word is \"#{winning_word[0]}\""
  puts "The letter #{winning_word[1][0]} is repeated #{winning_word[1][1]} times."
end

def read_from_file(filename)
  file = File.open(filename, "r")
  original_text = file.read
  text = original_text.downcase.gsub(/[^a-z0-9\s]/i, '')
end

# User Interaction

puts "This program will identify the word in your text file with the most frequently repeated letter"
puts "Please enter the name or path of the file you wish to scan."
puts "For example, 'example.txt'"

filename = gets.strip

until filename.include?(".txt")
  puts "Please make sure you are entering a file name or path ending with .txt"
  filename = gets.strip
end

begin
  text = read_from_file(filename)
  sentence_analyzer(text)
rescue Errno::ENOENT => e
  puts "No such file, please try again."
end