# frozen_string_literal: true

# !usr/local/bin/ruby
require_relative '../lib/paternit_scraper.rb'
require 'open-uri'
require 'nokogiri'
require 'colorize'

puts
puts '  Welcome to Web Scraper for Paternit.com!  '.colorize(color: :black, background: :yellow).center(74)
title = <<~TITLE

  \
              +++-++-++-++-++-++-++-++-++-++-++++
               |W||e||b||-||S||c||r||a||p||e||r|
              +++-++-++-++-++-++-++-++-++-++-++++
              +-++-++-++-++-++-++-++-++-+-++-++-+
              |P||a||t||e||r||n||i||t||.|c||o||m|
              +-++-++-++-++-++-++-++-++-+-++-++-+

                     by maosan132 \u00A9 2020

TITLE
puts title.center(30).colorize(color: :yellow, background: :black).center(90).bold

puts 'This app retrieves the next information: product name, usage and prices'
puts 'from the price list web page of manufacturer company Paternit SA.'
puts
def starts_app
  puts 'Select a number out of the following categories:'.bold
  puts
  print '(1) Adhesives | (2) Waterproofing | (3) Anchor systems | (4) Paints | (5) Cleaners | (6) Sealers ' + '?___ '.bold.yellow
  puts
  user_choice = gets.chomp.to_i
  categories = ['', 'Adhesives', 'Waterproofing', 'Anchor systems', 'Paints', 'Cleaners', 'sealers']
  selected = categories[user_choice]
  loop do
    break if [1, 2, 3, 4, 5, 6].include?(user_choice)

    print " #{user_choice} is an invalid choice! Please enter one of the following digits: 1 | 2 | 3 | 4 | 5 | 6"
    user_choice = gets.chomp.to_i
  end

  terms = case user_choice
          when 1
            ".card:contains('adhesivo'), .card:contains('pegas'),.card:contains('soldadura'), .card:contains('pegante')"
          when 2
            ".card:contains('impermeabiliza'), .card:contains('filtraciones'),.card:contains('humedad')"
          when 3
            ".card:contains('anclaje')"
          when 4
            ".card:contains('vinilo'), .card:contains('esmalte')"
          when 5
            ".card:contains('limpia')"
          when 6
            ".card:contains('sellante'), .card:contains('sellador'),.card:contains('Sellante')"
    end

  def loader
    print 'loading ['
    17.times do
      sleep 0.02
      print '.'.light_red
      sleep 0.02
      print '.'.light_yellow
      sleep 0.02
      print '.'.light_blue
    end
    puts ']'
    sleep 1
  end
  puts "Your choice was: #{user_choice}, which will search items in category " + "#{selected}:".yellow
  loader
  puts
  new_scraper = PaternitScraper.new
  new_scraper.scraper(terms)
end

starts_app
puts
