require_relative '../repeating_letters_logic'
require 'pry'

describe "Test File Inputs" do

  
  it "should return 'wherefore' from romeo.txt" do
    word = run_repeating_letters("spec/test_files/romeo.txt")
    expect( word ).to eq("wherefore")
  end
  
  it "should ignore punctuation and return 'zoom' from punctuation.txt" do
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
  
  it "should maintain all formatting and punctuation in the answer string" do
    word = run_repeating_letters("spec/test_files/original_formatting.txt")
    expect( word ).to eq("s-U-n-Nn'!y")
  end
  
end