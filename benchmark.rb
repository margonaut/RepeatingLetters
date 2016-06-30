require 'benchmark'
require_relative 'repeating_letters_logic'
require_relative 'repeating_letters_logic2'
require_relative 'original_program_logic'
require 'ruby-prof'

# puts Benchmark.measure { run_repeating_letters("spec/test_files/war_and_peace.txt") }

puts "\n Repeating Letters - Updated Version \n "
Benchmark.bm do |x|
  x.report("Romeo") { run_repeating_letters("spec/test_files/romeo.txt") }
  x.report("War and Peace") { run_repeating_letters("spec/test_files/war_and_peace.txt") }
end

puts "\n\n\------------------------\n\n\ "

puts "Repeating Letters - First Version \n\ "
Benchmark.bm do |x|
  x.report("Romeo") { run_original_program("spec/test_files/romeo.txt") }
  x.report("War and Peace") { run_original_program("spec/test_files/war_and_peace.txt") }
end


# profile the code
# RubyProf.measure_mode = RubyProf::MEMORY
RubyProf.start
puts 'updated version - war and peace'
 run_repeating_letters("spec/test_files/war_and_peace.txt")
result = RubyProf.stop

# print a flat profile to text
printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)

# RubyProf.measure_mode = RubyProf::MEMORY
RubyProf.start
puts 'updated version - war and peace'
 run_original_program("spec/test_files/war_and_peace.txt")
result = RubyProf.stop

# print a flat profile to text
printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)