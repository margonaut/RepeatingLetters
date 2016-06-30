require_relative '../repeating_letters_logic'
require 'pry'
require 'stringio'

describe "get_file_name" do
  describe "valid input" do
    before do
      $stdin = StringIO.new("text.txt\n")
    end
    after do
      $stdin = STDIN
    end
    it "should return the stripped string of a valid file input" do
      expect(get_file_name).to be == "text.txt"
    end
  end
end

describe "open_file" do
  it "should return a File object for a valid file path" do
    expect( open_file('spec/test_files/valid.txt').class ).to eq(File)
  end
  
  it "should rescue an invalid file path and output an error message" do
    expect{ 
      open_file('spec/test_files/invalid.txt') 
    }.to output("No such file.\n").to_stdout
  end
end

describe "read_text_from_file" do
  it "should return the text of a valid file" do
    file = open_file('spec/test_files/valid.txt')
    expect( read_text_from_file(file) ).to eq "Example text file."
  end
  
  it "should abort if the text file is empty" do
    file = open_file('spec/test_files/empty.txt')
    begin
      expect( read_text_from_file(file) ).should raise_error SystemExit
    rescue SystemExit
    end  
  end
  
  it "should abort if the text file contains less than two viable characters" do
    file = open_file('spec/test_files/too_short.txt')
    begin
      expect( read_text_from_file(file) ).should raise_error SystemExit
    rescue SystemExit
    end
  end
end

describe "get_winning_word" do
  it "should return the word with the most frequent repeating letter" do
    text = "Romeo, Romeo, wherefore art thou Romeo?"
    expect( get_winning_word(text) ).to eq("wherefore")
  end
  
  it "should return the first occuring word in the event of a tie" do
    text = "what's that? What's THAT!??"
    expect( get_winning_word(text) ).to eq("that?")
  end
  
  it "should ignore punctuation" do
    text = "break-n-fix break-n-fix zoom"
    expect( get_winning_word(text) ).to eq("zoom")
  end
  
  it "should consider upper and lower case letter the same" do
    text = "fOod Food"
    expect( get_winning_word(text) ).to eq("fOod")
  end
  
  it "should return the correct word with original formatting and punctuation" do
    text = "It's a bright and s-U-n-Nn'!y day"
    expect( get_winning_word(text) ).to eq("s-U-n-Nn'!y")
  end
end

describe "has_repeated_letters?" do
  it "should return true for a string with repeated letters" do
    expect( has_repeated_letters?("woods") ).to eq(true)
  end
  
  it "should return false for a string with no repeated letters" do
    expect( has_repeated_letters?("taken") ).to eq(false)
  end
end

describe "score_word" do
  it "should return 3 for input 'ghooost'" do
    expect( score_word("ghooost") ).to eq(3)
  end
  
  it "should return 4 for input 'bananagrams'" do
    expect( score_word("bananagrams") ).to eq(4)
  end
end