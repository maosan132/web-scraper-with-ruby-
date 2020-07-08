# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'colorize'
require 'pry'
class PaternitScraper
  attr_reader :url, :html, :parsed_html, :data, :info, :matches, :terms, :titles_of_every_match

  def initialize
    @url ||= 'http://precios.paternit.com'
    parser(html)
  end

  def html
    @html ||= open(@url)
  end

  def parser(html)
    @parsed_html ||= Nokogiri::HTML(html)
  end

  def scraper(terms)
    @data = parsed_html.css("#{terms}")
    @matches = data.count
    titles_of_every_match = data.css('.card-title').map(&:text)
    paragraphs_of_every_match = data.css('p').map(&:text)
    tables_of_every_match = data.css('table')
    @info = { titles: titles_of_every_match,
              paragraphs: paragraphs_of_every_match,
              tables: tables_of_every_match }
              puts 
    display_results()
  end

  def adds_line
    puts '-' * 85
  end

private

  def display_results
    puts "#{matches} products matches your search:  #{titles_of_every_match}"
    (0..matches - 1).each do |i|
      puts
      price_rows = info[:tables][i].css('td').count / 2
      puts "#{i + 1}. #{info[:titles][i]}".center(4).yellow.bold
      adds_line
      puts info[:paragraphs][i]
      adds_line
      puts 'Price List:'.center(40)
      a = info[:tables][i].css('th[1]').text.upcase.center(15).black.on_yellow.bold
      b = info[:tables][i].css('th[2]').text.upcase.center(15).black.on_yellow.bold
      puts "     #{a}|#{b}"
      c = info[:tables][i].css('td[1]').map { |i| i.text.center(15).underline }
      d = info[:tables][i].css('td[2]').map { |i| i.text.center(15).underline }
      (0..price_rows - 1).each do |i|
          puts "     #{c[i]}|#{d[i]}\n"
      end
      price_rows = 0
    end
  end
end

# new_scraper = PaternitScraper.new
# terms = ".card:contains('vinilo'), .card:contains('esmalte')"
# new_scraper.scraper(terms)
# puts "---"
# puts new_scraper.matches