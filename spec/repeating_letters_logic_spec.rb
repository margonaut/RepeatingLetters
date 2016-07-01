require_relative '../repeating_letters_logic'
require 'stringio'


describe "run_repeating_letters" do
  
  describe "handle different file states" do
    
    it "should handle valid file name" do
      word = run_repeating_letters('spec/test_files/valid.txt')
      expect( word ).to eq("Example")
    end
    
    it "should exit with an error when given an invalid path" do
      expect{ 
        run_repeating_letters('spec/test_files/sdfsdfvalid.txt') 
      }.to output("No such file.\n").to_stdout
    end
    
    it "should exit with an error when given an empty file" do
      expect{ 
        run_repeating_letters("spec/test_files/empty.txt")
      }.to output("Your file contains no valid words.\n").to_stdout
    end
    
    it "should exit with error when given a file containing less than two suitable characters" do
      expect{ 
        run_repeating_letters("spec/test_files/too_short.txt")
      }.to output("Your file contains no valid words.\n").to_stdout
    end
    
    it "should continue when given a file containing at least two valid characters" do
      word = run_repeating_letters("spec/test_files/just_long_enough.txt")
      expect( word ).to eq("aa")
    end
    
    it "should exit with an error if the text file contains no words with repeating letters" do
      expect{ 
        run_repeating_letters("spec/test_files/no_repeats.txt") 
      }.to output("Your file contains no valid words.\n").to_stdout
    end
    
    it "should exit with an error when given a file containing only punctuation" do
      expect{ 
        run_repeating_letters("spec/test_files/punctuation_only.txt") 
      }.to output("Your file contains no valid words.\n").to_stdout
    end
  end
  
  describe "return the correct word from text files with various content" do
    
    it "should return 'wherefore' from romeo.txt" do
      word = run_repeating_letters("spec/test_files/romeo.txt")
      expect( word ).to eq("wherefore")
    end
    
    it "should ignore repeated punctuation and return 'zoom' from punctuation.txt" do
      word = run_repeating_letters("spec/test_files/punctuation.txt")
      expect( word ).to eq("zoom")
    end
    
    it "should return the first qualifying winner word in the event of a tie" do
      word = run_repeating_letters("spec/test_files/ties.txt")
      expect( word ).to eq("hello!")
    end
    
    it "should treat upper and lower case equaly and return 'foOd' from capitalization.txt" do
      word = run_repeating_letters("spec/test_files/capitalization.txt")
      expect( word ).to eq("foOd")
    end
    
    it "should return the full text of a word made of a single letter" do
      word = run_repeating_letters("spec/test_files/single_letter.txt")
      expect( word ).to eq("aaaaaaaaaaaa")
    end
    
    it "should maintain all formatting and punctuation in the answer string" do
      word = run_repeating_letters("spec/test_files/original_formatting.txt")
      expect( word ).to eq("s-U-n-Nn'!y")
    end
    
    it "should can handle multi line text content" do
      word = run_repeating_letters("spec/test_files/multi_line.txt")
      expect( word ).to eq("weeeee")
    end
  end
end

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

describe "score_word" do
  
  it "should return 0 for '*!-&&&#'" do
    expect( score_word("*!-&&&#") ).to eq(0)
  end
  
  it "should return 1 for '*a!-#'" do
    expect( score_word("*a!-#") ).to eq(1)
  end
  
  it "should return 3 for input 'ghooost'" do
    expect( score_word("gh-o-O-ost") ).to eq(3)
  end
  
  it "should return 4 for input 'bananagrams'" do
    expect( score_word("_b.a.n.a.n.a.g.r.a.m.s_") ).to eq(4)
  end
end