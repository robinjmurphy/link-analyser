require 'nokogiri'

class Analyser
  def self.analyse html
    @links = { absolute: [], relative: [] }
    
    document = Nokogiri::HTML(html)
    document_links = document.xpath('//a[@href]')

    document_links.each do |document_link|
      link = { href: document_link.attribute('href').value, text: document_link.content }
      @links[:absolute].push link if link[:href].is_absolute_url
      @links[:relative].push link unless link[:href].is_absolute_url
    end

    return @links
  end
end

class String
  def is_absolute_url
    self.match /^(https?:)?\/\//
  end
end