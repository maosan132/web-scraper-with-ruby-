# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'

uri = 'http://precios.paternit.com/'
parsed_html = Nokogiri::HTML(open(uri)) # make the html page a nokogiri object

# separator = '═════════════════════════'.center(12)
# puts "     #{separator}"
#----------------@doc.css(".card:contains('Pegante')").css('thead').css('tr').each {|i| puts i}
puts

# data = parsed_html.css(".card:contains('#{term}')")
# tables_of_every_match = data.css('table').map(&:text)

# @doc.css(".card:contains('Pegante')").css('thead').css('tr').css('th[1]').text

term = 'Sellante'
data = parsed_html.css(".card:contains('#{term}')")
matches = data.count
titles_of_every_match = data.css('.card-title').map(&:text)
paragraphs_of_every_match = data.css('p').map(&:text)
tables_of_every_match = data.css('table')
info = { titles: titles_of_every_match, paragraphs: paragraphs_of_every_match, tables: tables_of_every_match }
p titles_of_every_match
puts info[:paragraphs][1]
puts info[:tables][1]

puts '----'
puts info[:tables][2].css('td[1]').map(&:text)
puts '*****'
row_counter = 0
puts "#{matches} products matches your search:".red
(0..matches - 1).each do |i|
  puts '-' * 30
  puts "#{i}. #{info[:titles][i]}"
  puts '-' * 30
  puts info[:paragraphs][i]
  puts '-' * 30
  puts 'Price List'
  puts '-' * 30
  a = info[:tables][i].css('th[1]').text.upcase.center(12)
  b = info[:tables][i].css('th[2]').text.upcase.center(12)
  puts "     #{a}|#{b}"
  c = info[:tables][i].css('td[1]').map(&:text)
  d = info[:tables][i].css('td[2]').map(&:text)

  puts "     #{c}|#{d}\n"

  row_counter += 1
end
puts '-' * 30
