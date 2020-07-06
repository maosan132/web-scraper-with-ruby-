# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'

class PaternitScraper
  attr_reader :doc, :url, :html, :term, :items

  def initialize(_url = nil)
    @url ||= 'http://precios.paternit.com' # In case of futures updates of the page it had a subdirectory sharing the same structure
    parser(html) # aka: paternit.com/distribuidores --> it would have different prices
  end

  def html
    @html ||= open(@url) # Uses open-uri and asigns @url to @html
  end

  def parser(html)
    @doc ||= Nokogiri::HTML(html) # Creates Nokogiri object
  end

  # maybe above methods should go in a superclass "scraper"

  def scraper(terms) # takes the selected term and loops x doc to create
    parent = doc.css(".card:contains('#{term}')")
    titles_of_every_match = parent.css(".card-title").map(&:text)
    paragraphs_of_every_match = parent.css("p").map(&:text)
    tables_of_every_match = parent.css("table").map(&:text)
    tables_of_every_match{|i| i.gsub!("\n", ' ').gsub!("\t", ' ').split.join(' ')}

    end
    titles = doc.css("h4:contains('#{term}')").map(&:text)
    paragraphs = doc.css("p:contains('#{term}')").map(&:text)
  end

  def is_dual_packaging?; end

  def table_row_counter
    doc.css('.card-title').count # 156 elements so far
  end

  def formatter(results)
    results.map(&:upcase!)
  end

  def all_products_counter
    doc.css('.card-title').count # 156 elements so far
  end

  def count_matches(_terms)
    matches = @doc.css("p:contains('#{term}')").length
  end

  def products_matcher(_terms)
    doc.css('p:contains("Adhesivo")').map(&:text).count
  end

  def product_name(fdf); end

  def product_usage; end

  def product_prices; end

  def product_price_headings; end

  def product_row_count; end

  def product_rows; end
end
