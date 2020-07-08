# frozen_string_literal: true

require './lib/paternit_scraper'
require 'nokogiri'

# rubocop:disable Metrics/BlockLength
describe PaternitScraper do
  let(:parsed_page) { Nokogiri::HTML(open('http://precios.paternit.com')) }
  let(:object) { PaternitScraper.new }
  let(:keys) { ".card:contains('vinilo'), .card:contains('esmalte')" }

  # rubocop:enable Metrics/BlockLength
  describe '#parser' do
    it 'returns a Nokogiri document' do
      expect(object.parser(parsed_page).class).to eq(Nokogiri::HTML::Document)
    end
  end

  describe '#scraper' do
    it 'grabs data user requested from fetched page' do
      data = object.scraper(keys)
      expect(data.class).to eq(Range)
    end
    it 'populates a hash with data fetched' do
      object.scraper(keys)
      expect(object.info.class).to eq(Hash)
    end
    it 'should call #gather_results' do
      expect(object).to receive(:gather_results)
      object.scraper(keys)
    end
  end

  describe '#gather_results' do
    it "store data from #parser info hash, into 'titles' array" do
      object.scraper(keys)
      expect(object.titles.class).to eq(Array)
    end
    it "store data from #parser info hash, into 'paragraphs' array" do
      object.scraper(keys)
      expect(object.paragraphs.class).to eq(Array)
    end
    it "store data from #parser info hash, into 'tables' nokogiry node set" do
      object.scraper(keys)
      expect(object.tables.class).to eq(Nokogiri::XML::NodeSet)
    end
    it 'should call #display_results' do
      expect(object).to receive(:display_results)
      object.scraper(keys)
    end
  end

  describe '#display_results' do
    it 'prints to screen results of operations' do
      object.scraper(keys)
      expect { object.display_results }.to output(String).to_stdout
    end
  end
end
