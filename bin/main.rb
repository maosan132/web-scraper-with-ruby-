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
#    The table rows should be colorized alternatively on even and odd rows.
#    In a future version, instead of showing a table with sizes, user should select what size he wants from an array of choices
# 4.1 Rspec that script finds a match and output it like the requirements.
# 5. ask user if wants to make another search
# 5.1 If user say yes, Rspec that the method restarts the app
puts
puts '  Welcome to Web Scraper for Paternit.com!  '.colorize(color: :black, background: :yellow).center(74)
title = <<~TITLE

  \
              +++-++-++-++-++-++-++-++-++-++-++++
               |W||e||b||-||S||c||r||a||p||e||r|
              +++-++-++-++-++-++-++-++-++-++-++++
              +-++-++-++-++-++-++-++-++-+-++-++-+
              |P||a||t||e||r||n||i||t||.|c||o||m|
              +-++-++-++-++-++-++-++-++-+-++-++-+

                     by maosan132 \u00A9 2020

TITLE
puts title.center(30).colorize(color: :yellow, background: :black).center(90).bold

puts 'This app retrieves the next information: product name, usage and prices'
puts 'from the price list web page of manufacturer company Paternit SA.'
puts
puts 'Select a number out of the following categories:'.bold
print '(1) Adhesives | (2) Waterproofing | (3) Anchor systems | (4) Paints | (5) Cleaners | (6) Sealers | (7) All ' + '?___ '.bold.yellow

user_choice = gets.chomp.to_i

loop do
  break if [1, 2, 3, 4, 5, 6, 7].include?(user_choice)

  puts 'Invalid choice! Please enter one of the following digits: 1 | 2 | 3 | 4 | 5 | 6'
  user_choice = gets.chomp.to_i
end

terms = case user_choice
        when 1
          '.card:contains('adhesivo'), .card:contains('pegas'),.card:contains('soldadura'), .card:contains('pegante')'
        when 2
          '.card:contains('impermeabiliza'), .card:contains('filtraciones'),.card:contains('humedad')'
        when 3
          '.card:contains('anclaje')'
        when 4
          '.card:contains('vinilo'), .card:contains('esmalte')'
        when 5
          '.card:contains('limpia')'
        when 6
          '.card:contains('sellante'), .card:contains('sellador'),.card:contains('Sellante')'
        when 7
          ''
  end

# binding.pry
# puts "choice was: #{terms}"
new_scraper = PaternitScraper.new
new_scraper.scraper(terms)
