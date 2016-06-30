require_relative '../repeating_letters_logic'
require 'pry'

describe "Test File Inputs" do
  it "should return 'Example' from example.txt" do
    word = run_repeating_letters("spec/test_files/valid.txt")
    expect( word ).to eq("Example")
  end
  
  it "should return 'wherefore' from romeo.txt" do
    word = run_repeating_letters("spec/test_files/romeo.txt")
    expect( word ).to eq("wherefore")
  end
  
  it "should ignore punctuation and return 'zoom' from punctuation.txt" do
    word = run_repeating_letters("spec/test_files/punctuation.txt")
    expect( word ).to eq("zoom")
  end
  
  it "should return the first qualifying winner word in the event of a tie" do
    word = run_repeating_letters("spec/test_files/tie.txt")
    expect( word ).to eq("hello!")
  end
  
  it "should treat upper and lower case equaly and return 'foOd' from capitalization.txt" do
    word = run_repeating_letters("spec/test_files/capitalization.txt")
    expect( word ).to eq("foOd")
  end
  
  it "should exit on an empty file" do
    begin
      expect( run_repeating_letters("spec/test_files/empty.txt") ).should raise_error SystemExit
    rescue SystemExit
    end
  end
  
  it "should exit on a file containing less than two suitable characters" do
    begin
      expect( run_repeating_letters("spec/test_files/too_short.txt") ).should raise_error SystemExit
    rescue SystemExit
    end
  end
  
  it "should continue and return 'aa' on a file with at least two suitable characters" do
    word = run_repeating_letters("spec/test_files/just_long_enough.txt")
    expect( word ).to eq("aa")
  end
  
  it "should output an error message if the text file contains no words with repeating letters" do
    expect{ 
      run_repeating_letters("spec/test_files/no_repeats.txt") 
    }.to output("No repeating letters.\n").to_stdout
  end
end