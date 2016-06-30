require_relative '../repeating_letters_logic'
require 'pry'
require 'stringio'

# handle valid file
# handle invalid path
# handle empty file
# handle file with too short content
# handle file with just enough content
# handle a file 

describe "run_repeating_letters" do
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
end

# describe "open_file" do
#   it "should return a File object for a valid file path" do
#     expect( open_file('spec/test_files/valid.txt').class ).to eq(File)
#   end
# end

# describe "read_text_from_file" do
#   it "should return the text of a valid file" do
#     file = open_file('spec/test_files/valid.txt')
#     expect( read_text_from_file(file) ).to eq "Example text file."
#   end
#   
#   it "should abort if the text file is empty" do
#     file = open_file('spec/test_files/empty.txt')
#     begin
#       expect( read_text_from_file(file) ).should raise_error SystemExit
#     rescue SystemExit
#     end  
#   end
#   
#   it "should abort if the text file contains less than two viable characters" do
#     file = open_file('spec/test_files/too_short.txt')
#     begin
#       expect( read_text_from_file(file) ).should raise_error SystemExit
#     rescue SystemExit
#     end
#   end
# end

#   
  # it "should return the first occuring word in the event of a tie" do
  #   text = "what's that? What's THERE!??"
  #   expect( get_winning_word(text) ).to eq("that?")
  # end

# repeated letters

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