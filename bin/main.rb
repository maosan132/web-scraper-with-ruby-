# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'

# attepmt # 1

html_data = open('http://precios.paternit.com/').read
nokogiri_object = Nokogiri::HTML(html_data)
price_elements = nokogiri_object.xpath('')

waterproofing_elements.each do |element|
  puts element.text
end

open('http://precios.paternit.com/')
dom_document = _ # last return or temp_file
dom_document.read

# attempt # 2
