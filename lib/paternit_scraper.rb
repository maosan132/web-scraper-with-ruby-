# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
# require 'pry'
require 'colorize'

class PaternitScraper
  attr_reader :url, :html, :parsed_html, :data, :info, :matches, :terms, :matches, :titles_of_every_match

  def type(i)
    puts "#{i}"
  end

  def initialize
    @url ||= 'http://precios.paternit.com' # In case of futures updates of the page it had a subdirectory sharing the same structure
    parser(html) # aka: paternit.com/distribuidores --> it would have different prices
  end

  def html
    @html ||= open(@url) # Uses open-uri and asigns @url to @html
  end

  def parser(html)
    @parsed_html ||= Nokogiri::HTML(html) # Creates Nokogiri object
  end

  def scraper(terms)
    # data = parsed_html.css(".card:contains('vinilo'), .card:contains('esmalte')")
    data = parsed_html.css("#{terms}")
    @matches = data.count
    titles_of_every_match = data.css('.card-title').map(&:text)
    paragraphs_of_every_match = data.css('p').map(&:text)
    tables_of_every_match = data.css('table')
    @info = { titles: titles_of_every_match,
              paragraphs: paragraphs_of_every_match,
              tables: tables_of_every_match }
    display_results()
  end

  def separer
    puts '-' * 85
  end
  # maybe above methods should go in a superclass "scraper"

private

  def display_results
    puts "#{matches} products matches your search:  #{titles_of_every_match}"
    (0..matches - 1).each do |i|
      puts
      price_rows = info[:tables][i].css('tr').count - 1
      puts "#{i + 1}. #{info[:titles][i]}".center(4).red.bold
      separer
      puts info[:paragraphs][i]
      separer
      puts 'Price List'
      separer
      a = info[:tables][i].css('th[1]').text.upcase.center(15).white.on_red.bold
      b = info[:tables][i].css('th[2]').text.upcase.center(15).white.on_red.bold
      puts "     #{a}|#{b}"
      c = info[:tables][i].css('td[1]').map { |i| i.text.center(15) }
      d = info[:tables][i].css('td[2]').map { |i| i.text.center(15) }
      (0..price_rows - 1).each do |i|
        puts "     #{c[i]}|#{d[i]}\n"
        #puts "     #{c[i].underline}|#{d[i].underline}\n"
      end
      price_rows = 0
      puts
    end
  end
end
# terms = ".card:contains('vinilo'), .card:contains('esmalte')"
# new_scraper = PaternitScraper.new
# new_scraper.type("mother_of_God")
# new_scraper.scraper(terms)
