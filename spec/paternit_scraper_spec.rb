require './lib/paternit_scraper'

describe PaternitScraper do
  let(:parsed_page) {Nokogiri::HTML(open('http://precios.paternit.com'))}
  let(:object) {PaternitScraper.new}
  let(:keys) {(".card:contains('vinilo'), .card:contains('esmalte')")}

  # let(:my_scraper_title) { Scraper.new.get_title('https://dev.to/', 'a', '.crayons-story__title') }
  # let(:my_scraper_author) { Scraper.new.get_author('https://dev.to/', '.crayons-story__title') }
  # let(:my_scraper_urls) { Scraper.new.get_post_url('https://dev.to/', '[id^="article-link-"]') }

  describe 'parser' do
    it 'returns a Nokogiri document' do
      expect(parsed_page.class).to eq(Nokogiri::HTML::Document)
    end
  end

  describe '#scraper' do
    it 'grabs data from fetched web page' do
      expect(object.scraper(keys).data).to eq(scrapped_object(terms))
    end
  end
end

