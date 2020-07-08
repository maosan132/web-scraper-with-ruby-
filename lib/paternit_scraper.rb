require 'open-uri'
require 'nokogiri'
require 'colorize'
class PaternitScraper
  attr_reader :parsed_html, :data, :info, :titles_of_every_match,
              :matches, :terms, :titles, :paragraphs, :tables

  def initialize
    @url = 'http://precios.paternit.com'
    parser(html)
  end

  # rubocop:disable Security/Open
  def html
    @html ||= open(@url)
  end
  # rubocop:enable Security/Open

  # rubocop:disable Naming/MemoizedInstanceVariableName
  def parser(html)
    @parsed_html ||= Nokogiri::HTML(html)
  end
  # rubocop:enable Naming/MemoizedInstanceVariableName

  def scraper(terms)
    @data = parsed_html.css(terms.to_s)
    @matches = data.count
    titles_of_every_match = data.css('.card-title').map(&:text)
    paragraphs_of_every_match = data.css('p').map(&:text)
    tables_of_every_match = data.css('table')
    @info = { titles: titles_of_every_match,
              paragraphs: paragraphs_of_every_match,
              tables: tables_of_every_match }
    puts
    gather_results
  end

  def adds_line
    puts '-' * 85
  end

  def gather_results
    @titles = info[:titles]
    @paragraphs = info[:paragraphs]
    @tables = info[:tables]
    display_results
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Lint/ShadowingOuterLocalVariable

  def display_results
    puts "#{matches} products matches your search:  #{titles_of_every_match}"
    (0..matches - 1).each do |item|
      puts
      price_rows = tables[item].css('td').count / 2
      puts "#{item + 1}. #{titles[item]}".center(4).yellow.bold
      adds_line
      puts paragraphs[item]
      adds_line
      puts 'Price List:'.center(40)
      a = tables[item].css('th[1]').text.upcase.center(15).black.on_yellow.bold
      b = tables[item].css('th[2]').text.upcase.center(15).black.on_yellow.bold
      puts "     #{a}|#{b}"
      c = tables.css('td[1]').map { |item| item.text.center(15).underline }
      d = tables.css('td[2]').map { |item| item.text.center(15).underline }
      (0..price_rows - 1).each do |i|
        puts "     #{c[i]}|#{d[i]}\n"
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Lint/ShadowingOuterLocalVariable
end

# new_scraper = PaternitScraper.new
# terms = ".card:contains('limpia')"
# new_scraper.scraper(terms)
# puts "---"
