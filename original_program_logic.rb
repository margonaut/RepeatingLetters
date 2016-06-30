def run_original_program(filename)
  text = read_from_file(filename)
  find_winning_word(text)
end

def read_from_file(filename)
  file = File.open(filename, "r")
  original_text = file.read
  text = original_text.downcase.gsub(/[^a-z0-9\s]/i, '')
end

def find_winning_word(text)
  analyzed_words = analyze_words(text)
  winning_word = analyzed_words.max_by {|k, v| v[1] }
  winning_word[0]
  # puts "The winning word is \"#{winning_word[0]}\""
  # puts "The letter #{winning_word[1][0]} is repeated #{winning_word[1][1]} times."
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