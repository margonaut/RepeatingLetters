require_relative '../repeating_letters_logic'

# describe "get_file" do
#   it "should prompt the user for a file path" do
#     
#   end
# end

# read_text_from_file
# get_winning_word

describe "has_repeated_letters?" do
  it "should return true for a string with repeated letters" do
    expect( has_repeated_letters?("woods") ).to eq(true)
  end
  
  it "should return false for a string with no repeated letters" do
    expect( has_repeated_letters?("taken") ).to eq(false)
  end
end
# score_word

describe "score_word" do
  it "should return 3 for input 'ghooost'" do
    expect( score_word("ghooost") ).to eq(3)
  end
  
  it "should return for input 'bananagrams'" do
    expect( score_word("bananagrams") ).to eq(4)
  end
end