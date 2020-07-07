# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'

uri = 'http://precios.paternit.com/'
parsed_html = Nokogiri::HTML(open(uri)) # make the html page a nokogiri object
$parsed_html = Nokogiri::HTML(open(uri))
d
whole_matches
data = parsed_html.css(".card:contains('#{term}'), .card:contains('#{term2}'),.card:contains('#{term3}'), .card:contains('#{term4}')")
matches = data.count
titles_of_every_match = data.css('.card-title').map(&:text)
paragraphs_of_every_match = data.css('p').map(&:text)
tables_of_every_match = data.css('table')
info = { titles: titles_of_every_match, paragraphs: paragraphs_of_every_match, tables: tables_of_every_match }

def line
  puts '-' * 85
end
puts
puts "#{matches} products matches your search:  #{titles_of_every_match}"
(0..matches - 1).each do |i|
  puts
  price_rows = info[:tables][i].css('tr').count - 1
  puts "#{i + 1}. #{info[:titles][i]}".center(4).red.bold
  line
  puts info[:paragraphs][i]
  line
  puts 'Price List'
  line
  a = info[:tables][i].css('th[1]').text.upcase.center(15).white.on_red.bold
  b = info[:tables][i].css('th[2]').text.upcase.center(15).white.on_red.bold
  puts "     #{a}|#{b}"
  c = info[:tables][i].css('td[1]').map { |i| i.text.center(15) }
  d = info[:tables][i].css('td[2]').map { |i| i.text.center(15) }
  (0..price_rows - 1).each do |i|
    puts "     #{c[i]}|#{d[i]}\n"
  end
  price_rows = 0
  puts
end

# data.at_css('tbody').css('tr').each do |row|
#
# puts
# puts key
#   a = row.css('th[1]').text.upcase.center(12)
#   b = row.css('th[2]').text.upcase.center(12)
#   puts "     #{a}|#{b}"

# c = row.css('td[1]').text.center(12)
# d = row.css('td[2]').text.center(12)
# if row_counter.odd?
#   print "     #{c}|#{d}\n"
# else
#   puts "     #{c.black.on_light_yellow}|#{d.black.on_light_blue}"
# end
# row_counter += 1
# end

# def show_tr_th(col)
#   $info[:tables][i].css("th[#{col}]").text.upcase.center(12).white.on_red.bold
# end
# def show_tr_td(col)
#   $info[:tables][i].css("td[#{col}]").map { |i| i.text.center(12) }
# end
