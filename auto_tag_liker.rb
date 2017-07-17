# This is a quick ruby script to scrape instagram for certain tags and like them.
# You can set a maximum number of likes per tag and use an unlimited number of
# ARGV arguments to search for different tags. The next step would be to add a
# method to inport a csv for search terms or tags.

# This program is a continuation of Seph Cordovano's video and github page:
# https://github.com/dv1pr/Web-Scraping-Tutorial
# Super big thanks to him for the videos and github share!

require 'watir' # Crawler
require 'watir-webdriver'
require 'pry' # Ruby REPL
require 'rb-readline' # Ruby IRB
require 'awesome_print' # Console output
require 'csv' #use built in csv library to import list of tags

# Use environment variable to store username and password
username = ENV['INSTAGRAM_USERNAME']
password = ENV['INSTAGRAM_PASSWORD']


# Set variable for CSV - tags.csv that makes more sense
input_tags = CSV.read('test.csv')

# Use ARGV to set the array of tags to loop through during the liking process
csv_length = input_tags.length


# initialize the like_counter variable to keep track of the loop throught the input tags
like_counter = 0

# initialize the hashtag number of likes variable to track the total number of likes
hashtag_like = 0

# Open Browser, Navigate to Login page
browser = Watir::Browser.new :chrome, switches: ['--incognito']
browser.goto "instagram.com/accounts/login/"

# Navigate to Username and Password fields, inject info
puts "Logging in..."
browser.text_field(:name => "username").set "#{username}"
browser.text_field(:name => "password").set "#{password}"

# Click Login Button
browser.button(:class => '_ah57t _84y62 _i46jh _rmr7s').click
sleep(2)
puts "We're in."

# set loop counter
loop_counter = 0

# Loop through all the ARGV arguments for each tag
while loop_counter < csv_length

  # Use the ARGV variable we stored the arguments in to loop through them
  input_tags.each do |input_t|

    # Set a local variable for the loop to track when a tag isn't found
    not_found = 0

    # visit specific hastags... This could be made more dynamic or use ARGV[2]

    browser.goto "instagram.com/explore/tags/#{input_tags[loop_counter][0]}/"
    sleep(2.0)

    browser.goto "instagram.com/explore/tags/#{input_t[0]}/"
    sleep(1.5)

    puts "we are looking for the tag: #{input_t}"

    # increment the loop counter after we login and have found
    # the first argument stored in input tags
    loop_counter +=1


    # click on most recent post - per https://github.com/dv1pr/Web-Scraping-Tutorial
    if browser.div(:class=>"_8mlbc _vbtk2 _t5r8b").exists?
      browser.div(:class=>"_8mlbc _vbtk2 _t5r8b").link.click
    else
      ap "Something went wrong or the tag has no posts"
    end

    # Set a variable to count the number of posts clicked
    posts_clicked = 0

    # Continuous loop - This loop runs until you have 5 posts not found or it
    # likes five posts. You can obviously change these values and increase the amount.

    while not_found < 10 && posts_clicked < 10

      # set a variable for the argv to print to the command line
      # Since we already incremented the loop_counter we need to correct
      # by subtracting one from the amount. This gives use the correct ARGV.
      input = input_t[loop_counter - 1]

      if browser.span(:class => "coreSpriteHeartOpen").exists?
        browser.span(:class => "coreSpriteHeartOpen").click
        like_counter += 1
        puts "Posts with hastag liked: #{like_counter}"
        not_found = 0
      else
        # This is a new section where we click through a number of posts for the
        # given tag we are using. This allows us to search for any tag and move
        # them while keeping track of the "Posts not found in a row".
        # I decided to make it look for a number of posts not found in a row as
        # sometimes you might have already like a post or two on your own
        # and we don't want the program to end unsless you are seeing a large number
        # of not found in a row.
        not_found += 1
        ap "This is number #{not_found} in a row we can't find."
      end

      # This section will click the right arrow and move through the tags
      if browser.a(:class =>"coreSpriteRightPaginationArrow").exists?
        browser.a(:class =>"coreSpriteRightPaginationArrow").click
        ap "clicked right arrow"
        sleep(1)
        posts_clicked +=1
      end

      ap "total number of clicked links-#{posts_clicked}"

      sleep(1)

    end

  end

  ap "All done for now!"
  # Leave this in to use the REPL at end of program
  # Otherwise, take it out and program will just end
  # Pry.start(binding)
end



