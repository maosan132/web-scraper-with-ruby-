require './lib/paternit_scraper'
require 'nokogiri'

describe PaternitScraper do
  let(:parsed_page) {Nokogiri::HTML(open('http://precios.paternit.com'))}
  let(:object) {PaternitScraper.new}
  let(:keys) {(".card:contains('vinilo'), .card:contains('esmalte')")}
  let(:all_titles) {}

  # let(:my_scraper_title) { Scraper.new.get_title('https://dev.to/', 'a', '.crayons-story__title') }
  # let(:my_scraper_author) { Scraper.new.get_author('https://dev.to/', '.crayons-story__title') }
  # let(:my_scraper_urls) { Scraper.new.get_post_url('https://dev.to/', '[id^="article-link-"]') }

  describe 'parser' do
    it 'returns a Nokogiri document' do
      expect(object.parser(parsed_page).class).to eq(Nokogiri::HTML::Document)
    end
  end

  describe '#scraper' do
    it 'grabs data user requested from fetched page' do
      data = object.scraper(keys)
      expect(data.class).to eq(Range)
    end
    it "populates a hash with arrays with data fetched" do
      object.scraper(keys)
      expect(object.info.class).to eq(Hash)
    end
    it "should call #display_results" do
      expect(object).to receive(:display_results)
      object.scraper(keys)
    end
  end

  describe '#display_results'
end

