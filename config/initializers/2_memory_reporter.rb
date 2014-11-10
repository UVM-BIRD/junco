require 'java'

mb = 2**20
runtime = Java::java.lang.Runtime.get_runtime

puts "\n** JVM INFO ********"
puts " Max Memory:  #{runtime.max_memory / mb}m"
puts " Used Memory: #{(runtime.total_memory - runtime.free_memory) / mb}m"
puts " Free Memory: #{runtime.free_memory / mb}m"
puts "\n\n"
