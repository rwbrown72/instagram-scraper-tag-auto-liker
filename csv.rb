require 'csv' #use built in csv library to import list of tags

# Set variable for CSV - tags.csv that makes more sense
tags = []
inc = 0

CSV.foreach('test.csv') do |row|

  tags[inc] = row
  puts "Before the i+=: #{inc}"
  puts  "We found #{tags[inc][0]}"
  inc += 1
  puts "After the i+=: #{inc}"
end



# # Use ARGV to set the array of tags to loop through during the liking process
# csv_length = input_tags.length
# puts csv_length
