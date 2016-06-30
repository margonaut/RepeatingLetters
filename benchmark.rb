require 'benchmark'
require_relative 'repeating_letters_logic'
require_relative 'original_program_logic'

# puts Benchmark.measure { run_repeating_letters("spec/test_files/war_and_peace.txt") }

puts "\n Repeating Letters - Updated Version \n "
Benchmark.bm do |x|
  x.report { run_repeating_letters("spec/test_files/romeo.txt") }
  x.report { run_repeating_letters("spec/test_files/war_and_peace.txt") }
end

puts "\n\n\------------------------\n\n\ "

puts "Repeating Letters - First Version \n\ "
Benchmark.bm do |x|
  x.report { run_original_program("spec/test_files/romeo.txt") }
  x.report { run_original_program("spec/test_files/war_and_peace.txt") }
end