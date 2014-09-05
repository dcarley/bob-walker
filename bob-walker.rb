#!/usr/bin/env/ruby
loop do
  puts "beard"
  puts "beer"
  puts "pie"
  case ARGV[0]
    when "-s"
      puts "rugby"
      puts "cricket"
    when "-x"
      puts "mince pies"
      puts "reindeer"
  end
end
