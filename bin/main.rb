# frozen_string_literal: true

# !usr/local/bin/ruby
require_relative '../lib/paternit_scraper.rb'
require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'

# steps

# 1. Present the script 'look for prices by category' that match a category.
# 2. Give an array of strings to select what kind of category of product client want to know its prices (in the future, it could be any word user wants to search)
# 2.1 Rspec if is showing the list
# 3. Take (and validate) the choice and pass it to a method that initializes the crawling
# 3.1 Rspec if the method accepts and validates the selection
# 4. Whenever the script finds a match or matches, it would output it in an appropiate form aka 'human understandable way'. These are the desirable/mandatory outputs:
#    Title of the categ, the description of product (from where the crawler takes the category name), table of prices with different packaging sizes.
#    In a future version, instead of showing a table with sizes, user should select what size he wants from an array of choices
# 4.1 Rspec that script finds a match and output it
# 5. ask user if wants to make another search
# 5.1 If user say yes, Rspec that the method restarts the app

title = <<~TITLE

  \
    ++-++-++-++-++-++-++-++-++-++-++-++
     |W||e||b||-||S||c||r||a||p||e||r|
    ++-++-++-++-++-++-++-++-++-++-++-++
    +-++-++-++-++-++-++-++-++-+-++-++-+
    |P||a||t||e||r||n||i||t||.|c||o||m|
    +-++-++-++-++-++-++-++-++-+-++-++-+

          by maosan132 \u00A9 2020

TITLE
puts title.colorize(color: :light_blue, background: :black)
puts 'Welcome to Web Scraper for Paternit.com!'.colorize(color: :light_blue, background: :yellow)
puts
puts 'This scraper retrieves the next information: title of product, description and prices'
puts 'from the price list page of manufacturer company Paternit.'
puts 'Select a number out of the following categories:'
puts '(1) Adhesives | (2) Waterproofing | (3) Anchor systems | (4) Paints | (5) Cleaners | (6) Sealers'

choice = ''
url = 'http://paternit.com'
# categories = ['', 'Adhesives', 'Waterproofing', 'Anchor systems', 'Paints', 'Cleaners', 'sealers']

loop do
  user_choice = gets.chomp
  break if %w[1 2 3 4 5 6 7 8 9].include?(user_choice)

  term = case user_choice
         when 1
           %w[adhesivo Adhesivo pegas Soldadura Pegante]
         when 2
           %w[impermeabilizante filtraciones humedad impermeabilizar]
         when 3
           %w[anclajes Anclajes Anclaje]
         when
    %w[Vinilo Esmalte]
         when
    %w[Limpia limpia]
         when
    %w[Sellante sellador Sellador]
         when
    %w[anclajes Anclajes Anclaje]
  end
  puts 'Invalid choice! Please enter one of the following digits: 1 | 2 | 3 | 4 | 5 | 6'
end

new_scraper = Paternit_scraper.new
new_scraper.fetcher(term)

if choice == '1'

  website = UdacityScraper.new(url)
elsif choice == 'indeed'
  url = 'https://www.indeed.com/jobs?q=Ruby+On+Rails&l=Remote&rbl=Remote&jlid=aaa2b906602aa8f5&sort=date'

  website = IndeedScraper.new(url)
elsif choice == 'remote.io'
  puts 'Welcome to webscraper for remote.io :)'
  puts 'The search keywords are as followed'
  puts '-----------------------------------------------------------------'
  puts '0:ruby, 1: javascript,2: ruby-on-rails,3: reactjs,4: python,5: java,6: php,7: kubernetes, 8: docker,9: flask'
  puts '-----------------------------------------------------------------'
  puts 'Please enter number / combination from above list (eg. 124 for javascript, ruby-on-rails, and python)'

  num = nil
  loop do
    num = gets.chomp.split('').map(&:to_i)
    break if num.all? { |i| i <= 9 && i >= 0 }

    # url = gets.chomp
    # break if url.match?(/^(https:..www.remote.io.remote-jobs.s=)/)

    puts 'Error! Please enter a valid search combination'
  end

  website = RemoteIoScraper.new(num)
end
