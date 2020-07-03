# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'

class PaternitScraper
  attr_reader :doc, :url, :html, :term, :items,

  def initialize(_url = nil)
    @url ||= 'http://precios.paternit.com' # In case of futures updates of the page it had a subdirectory sharing the same structure
    parser(html)                    # aka: paternit.com/distribuidores --> it would have different prices
  end

  def html
    @html ||= open(@url) # Uses open-uri and asigns @url to @html
  end

  def parser(html)
    @doc ||= Nokogiri::HTML(html) # Creates Nokogiri object
  end

  def formatter(term)
    term.downcase
  end

  def products_counter
    doc.css(".card-title").count #156
  end

  def count_matches(terms)
    term = formatter(term)
    matches = @doc.css('p:contains("#{term}")').length
  end

  def fetcher(terms)
    terms.each do |term| 
      @doc.css("p:contains('#{term}')").map(&:text)
    end
  end

  def products_matcher(terms)
    doc.css('p:contains("Adhesivo")').map(&:text).count
  end

  def product_name; end

  def product_usage; end

  def product_prices; end

  def product_price_headings; end

  def product_row_count; end

  def product_rows; end
end
