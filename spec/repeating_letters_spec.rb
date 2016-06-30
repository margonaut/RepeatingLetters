# require_relative '../repeating_letters'
# require 'pry'
# require 'stringio'
# 
# describe "Repeating Letters Program" do
#   describe "valid input" do
#     before do
#       $stdin = StringIO.new("spec/test_files/valid.txt")
#     end
#     after do
#       $stdin = STDIN
#     end
#     it "should return something" do
#       binding.pry
#       expect(get_file_name).to be == "text.txt"
#     end
#   end
# end