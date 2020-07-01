require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'
#
 html_data = open('http://precios.paternit.com/').read
# parsed_html = Nokogiri::HTML(html_data)
# price_elements = parsed_html.xpath('')

# waterproofing_elements.each do |element|
#   puts element.text
# end

# attempt # 2

# open('http://precios.paternit.com/')
# dom_document = _ # last return or temp_file
#fetched_page = open('http://precios.paternit.com/').read # html page saved to result
parsed_html = Nokogiri::HTML(open('http://precios.paternit.com/')) # make the html page a nokogiri object
# find name or term
product_card = parsed_html.css('.card') # all ocurrences w/ class card
# product_table = css('table.table') #
# product_title = css('.card-title') # have to follow something
# product_usage = css('.descrip') # have to follow something

# binding.pry

product_card.css('.card-text').first
product_card.css('.card-text').first.class.instance_methods.sort
product_card.css('.card-text').first.inner_text
puts 'grab prices'.colorize(:color => :black, :background => :yellow)
product_card.css('table').first.css('tbody').css('tr').css('td').class.instance_methods.sort

product_card.css('table').first.css('thead').css('tr').css('th').first.text # gets type of package
puts product_card.css('table').first.css('tbody').css('tr').css('td').first.text # gets named type of package
puts "last"
product_card.css('table').first.css('tbody').css('tr').css('td').each { |i| puts i } # nokorigi notation
puts "-----"
product_card.css('table').first.css('tbody').css('tr').css('td').each { |i| puts i.text } # text notation

# fetch description where term was found
# array = parsed_page.css(‘h2’).map(&:text)  # example

# each {|i| puts i}
#!/usr/bin/env ruby