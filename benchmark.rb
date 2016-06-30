require 'benchmark'
require 'repeating_letters_logic'

puts Benchmark.measure { "a"*1_000_000 }
