require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'
uri = 'http://precios.paternit.com/'
parsed_html = Nokogiri::HTML(open(uri)) # make the html page a nokogiri object
# find name or term
#product_card = parsed_html.css('.card') # all ocurrences w/ class card
# product_table = css('table.table') #
# product_title = css('.card-title') # have to follow something
# product_usage = css('.descrip') # have to follow something

# binding.pry

# product_card.css('.card-text').first
# product_card.css('.card-text').first.class.instance_methods.sort
# product_card.css('.card-text').first.inner_text
# puts 'grab prices'.colorize(:color => :black, :background => :yellow)
# product_card.css('table').first.css('tbody').css('tr').css('td').class.instance_methods.sort

# product_card.css('table').first.css('thead').css('tr').css('th').first.text # gets type of package
# puts product_card.css('table').first.css('tbody').css('tr').css('td').first.text # gets named type of package
# puts "last"
# product_card.css('table').first.css('tbody').css('tr').css('td').each { |i| puts i } # nokorigi notation
# puts "-----"
# product_card.css('table').first.css('tbody').css('tr').css('td').each { |i| puts i.text } # text notation

# fetch description where term was found
# array = parsed_page.css(‘h2’).map(&:text)  # example

# each {|i| puts i}
#!/usr/bin/env ruby

def colorize(str, color)
    str.bold.colorize(color: :black, background: :light_blue)
end


puts 
parsed_html.at('thead').search('tr').each do |row|
    puts
    separator = '════════════'.center(12).bold.colorize(color: :light_yellow)
    a = row.search('th[1]').text.upcase.center(12).cyan.on_blue.bold
    b = row.search('th[2]').text.upcase.center(12).colorize(color: :black, background: :light_yellow)
    puts "     #{a}|#{b}"
    puts "     #{separator}|#{separator}"
end
row_counter = 0
parsed_html.at('tbody').search('tr').each do |row|
    c = row.search('td[1]').text.center(12)
    d = row.search('td[2]').text.center(12)
    if row_counter.even?
      print "     #{c}|#{d}\n"
    else
      puts "     #{c.colorize(color: :black, background: :light_blue)}|#{d.colorize(color: :black, background: :light_blue)}"
    end
    row_counter += 1
end