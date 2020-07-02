# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'

class PaternitScraper
  # def data_crawler(url)
  #   Nokogiri::HTML(open(url))
  # end

  # def get_products
  #   base_url = ''
  #   main_url = "#{base_url}/"
  #   data = data_crawler(main_url)
  # end

  def def initialize(url = nil)
    @url ||= "http://paternit.com" # In case of futures updates of the page it had a subdirectory sharing the same structure
    parse(html)                    # aka: paternit.com/distribuidores --> it would have different prices
  end

  def html
    @html ||= open(@url) # Uses open-uri and asigns @url to @html
  end

  def parse(html)
    @doc ||= Nokogiri::HTML(html) # Creates Nokogiri object
  end

  def matches_count

  end

  def products_match

  end

  def product_name

  end

  def product_usage

  end

  def product_prices

  end

  def product_price_headings

  end

  def product_row_count

  end

  def product_rows

  end

end
