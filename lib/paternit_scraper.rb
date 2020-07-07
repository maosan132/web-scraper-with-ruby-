# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'

class PaternitScraper
  attr_reader :parsed_html, :data, :info
              :url, :html, :term, :items

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
    data = parsed_html.css("#{terms}")
    matches = data.count
    titles_of_every_match = data.css('.card-title').map(&:text)
    paragraphs_of_every_match = data.css('p').map(&:text)
    tables_of_every_match = data.css('table')
    info = { titles: titles_of_every_match, paragraphs: paragraphs_of_every_match, tables: tables_of_every_match }
  end

  def separer
    puts '-' * 85
  end
  # maybe above methods should go in a superclass "scraper"

  def display_results(terms) # takes the selected term and loops x parsed_html to create



    # parent = parsed_html.css(".card:contains('#{term}')")
    # titles_of_every_match = parent.css('.card-title').map(&:text)
    # paragraphs_of_every_match = parent.css('p').map(&:text)
    # tables_of_every_match = parent.css('table').map(&:text)
    # tables_of_every_match { |i| i.gsub!("\n", ' ').gsub!("\t", ' ').split.join(' ') }

    # titles = parsed_html.css("h4:contains('#{term}')").map(&:text)
    # paragraphs = parsed_html.css("p:contains('#{term}')").map(&:text)
  end

  def table_row_counter
    parsed_html.css('.card-title').count # 156 elements so far
  end


end

new_scraper = PaternitScraper.new
new_scraper.scraper(terms)
