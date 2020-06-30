# frozen_string_literal: true

# !usr/local/bin/ruby

require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'

# steps

# 1. Present the script "look for prices by category" that match a category.
# 2. Give an array of strings to select what kind of category of product client want to know its prices (in the future, it could be any word user wants to search)
# 2.1 Rspec if is showing the list
# 3. Take (and validate) the choice and pass it to a method that initializes the crawling
# 3.1 Rspec if the method accepts and validates the selection
# 4. Whenever the script finds a match or matches, it would output it in an appropiate form aka "human understandable way". These are the desirable/mandatory outputs:
#    Title of the categ, the description of product (from where the crawler takes the category name), table of prices with different packaging sizes.
#    In a future version, instead of showing a table with sizes, user should select what size he wants from an array of choices
# 4.1 Rspec that script finds a match and output it
# 5. ask user if wants to make another search
# 5.1 If user say yes, Rspec that the method restarts the app

# attepmt # 1

# html_data = open('http://precios.paternit.com/').read
# parsed_html = Nokogiri::HTML(html_data)
# price_elements = parsed_html.xpath('')

# waterproofing_elements.each do |element|
#   puts element.text
# end

# attempt # 2

# open('http://precios.paternit.com/')
# dom_document = _ # last return or temp_file
results = open('http://precios.paternit.com/').read # html page saved to result
parsed_html = Nokogiri::HTML(results) # make the html page a nokogiri object
# find name or term
parsed_html.css('.card')
parsed_html.css('.card').css('.card-text').first
parsed_html.css('.card').css('.card-text').first.class.instance_methods.sort
parsed_html.css('.card').css('.card-text').first.inner_text
# grab prices
parsed_html.css('.card').css('table').first.css('tbody').css('tr').css('td').class.instance_methods.sort

parsed_html.css('.card').css('table').first.css('thead').css('tr').css('th').first.text # gets type of package
puts parsed_html.css('.card').css('table').first.css('tbody').css('tr').css('td').first.text # gets named type of package
binding.pry
parsed_html.css('.card').css('table').first.css('tbody').css('tr').css('td').each { |i| puts i }
parsed_html.css('.card').css('table').first.css('tbody').css('tr').css('td').each { |i| puts i.text }

# each {|i| puts i}
