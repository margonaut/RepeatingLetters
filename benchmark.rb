require 'benchmark'
require_relative 'repeating_letters_logic'
require_relative 'original_program_logic'
require 'ruby-prof'

# Run this file to see a printout of time and efficiency benchmarks comparing
# the first solution to the new solution

puts "BENCHMARK TIMES \n"

puts "\n Repeating Letters - Updated Version \n "
Benchmark.bm do |x|
  x.report("Romeo:       ") { run_repeating_letters("spec/test_files/romeo.txt") }
  x.report("War and Peace:") { run_repeating_letters("spec/test_files/war_and_peace.txt") }
end

puts "\n\n\------------------------\n\n\ "

puts "Repeating Letters - First Version \n\ "
Benchmark.bm do |x|
  x.report("Romeo:        ") { run_original_program("spec/test_files/romeo.txt") }
  x.report("War and Peace:") { run_original_program("spec/test_files/war_and_peace.txt") }
end

puts "\n\nEFFICIENCY MEASURES"

puts "\n Repeating Letters - Updated Version"
puts "Running 'War and Peace'"

RubyProf.start
 run_repeating_letters("spec/test_files/war_and_peace.txt")
result = RubyProf.stop

printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)

puts "\n\n\------------------------\n\n\ "

puts "Repeating Letters - First Version"
puts "Running 'War and Peace'  \n "
RubyProf.start
 run_original_program("spec/test_files/war_and_peace.txt")
result = RubyProf.stop

printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)