#!/usr/bin/env/ruby
loop do
  puts "beard"
  puts "beer"
  puts "pie"
  case ARGV[0]
    when "-s"
      puts "rugby"
      puts "cricket"
  end
end
