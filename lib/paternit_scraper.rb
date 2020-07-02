# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'

class PaternitScraper
  attr_reader :url, :html, :term,
              # def data_crawler(url)
              #   Nokogiri::HTML(open(url))
              # end

              # def get_products
              #   base_url = ''
              #   main_url = "#{base_url}/"
              #   data = data_crawler(main_url)
              # end
              def initialize(_url = nil)
                @url ||= 'http://paternit.com' # In case of futures updates of the page it had a subdirectory sharing the same structure
                parse(html)                    # aka: paternit.com/distribuidores --> it would have different prices
              end

  def html
    @html ||= open(@url) # Uses open-uri and asigns @url to @html
  end

  def parse(html)
    @doc ||= Nokogiri::HTML(html) # Creates Nokogiri object
  end

  def formatter(term)
    term.downcase
  end

  def matches_count(term)
    term = formatter(term)
    matches = @doc.css('p:contains("#{term}")').length
  end

  def products_match; end

  def product_name; end

  def product_usage; end

  def product_prices; end

  def product_price_headings; end

  def product_row_count; end

  def product_rows; end
end
