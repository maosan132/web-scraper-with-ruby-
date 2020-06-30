# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'

class Scraper
  def parser(_url)
    Nokogiri::HTML()
  end
end
