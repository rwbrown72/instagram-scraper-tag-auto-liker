require 'csv' #use built in csv library to import list of tags

# Set variable for CSV - tags.csv that makes more sense
tags = []
inc = 0

CSV.foreach('tags.csv') do |row|
  puts row
  tags[inc] = row
  puts "Before the i+=: #{inc}"
  inc = inc + 1
  puts "After the i+=: #{inc}"
end

puts tags.inspect



# # Use ARGV to set the array of tags to loop through during the liking process
# csv_length = input_tags.length
# puts csv_length
