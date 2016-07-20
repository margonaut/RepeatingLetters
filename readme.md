# Repeating Letters

Programming exercise. This solution focuses on runtime efficiency.

For a given text file, return the word with the highest count of a repeating letter. Capitals and lower case letters count as the same character. Ignore punctuation. In the event of a tie, the word that appears first wins.

1. Project setup: bundle install

2. Run the program: ruby repeating_letters.rb

3. Unit Tests: rspec

4. Benchmarks comparing old and new versions: ruby benchmark.rb
   Sample runtime benchmarks:

    BENCHMARK TIMES

    Repeating Letters - Updated Version

                   user     system      total        real
    Romeo:         0.000000   0.000000   0.000000 (  0.001360)
    War and Peace: 2.630000   0.020000   2.650000 (  2.666257)

    ------------------------

    Repeating Letters - First Version

                    user     system      total        real
    Romeo:          0.000000   0.000000   0.000000 (  0.000302)
    War and Peace:  7.120000   0.090000   7.210000 (  7.291850)
