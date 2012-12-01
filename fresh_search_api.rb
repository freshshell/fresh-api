ENV['RACK_ENV'] ||= 'development'

require 'open-uri'
require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

class FreshSearchApi < Sinatra::Base
  set :cache, Dalli::Client.new

  get '/' do
    settings.cache.get('lines')
  end

  private

  def self.scrape
    lines = []
    doc = Nokogiri::HTML(open('https://github.com/freshshell/fresh/wiki/Directory'))
    doc.css('#wiki-body .markdown-body li').each do |li|
      fresh_line = li.css('code').text
      description = li.css('a').text
      link = li.css('a').attr('href').value

      lines << "`#{fresh_line}` # #{description} - #{link}"
    end
    settings.cache.set('lines', lines.join("\n"))
  end
end
