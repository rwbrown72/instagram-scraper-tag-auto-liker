# This is a small program to test getting inputs from ARGV and creating a loop with the array.

# # Set the counter variable to zero
# n = 0

# # Set the length of ARGV to a variable
# arg_length = ARGV.length

# # Loop through each variable and print out the argument
# while n < arg_length
#   puts ARGV[n]
#   n +=1
# end

require 'CSV'

arr = CSV.read('test.csv')

n = 0 

while n < arr.length
	p arr[n]
	n += 1
end

puts arr[0][0]