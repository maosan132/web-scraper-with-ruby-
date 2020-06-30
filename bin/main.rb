# frozen_string_literal: true

# !usr/local/bin/ruby

require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'

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
parsed_html.css('.card').css('table').first.css('tbody').css('tr').css('td').first.text # gets named type of package
