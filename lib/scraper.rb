# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'

class Scraper
  def data_crawler(url)
    Nokogiri::HTML(open(url))
  end

  def get_products
    base_url = ''
    main_url = "#{base_url}/"
    data = data_crawler(main_url)
  end
end
