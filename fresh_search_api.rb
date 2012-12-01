ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

require 'open-uri'
require 'sinatra/reloader' if Sinatra::Base.development?

class FreshSearchApi < Sinatra::Base
  get '/' do
    #

  private

  def self.scrape
    doc = Nokogiri::HTML(open('https://github.com/freshshell/fresh/wiki/Directory'))
    doc.css('#wiki-body .markdown-body li').each do |li|
      fresh_line = li.css('code').text
      description = li.css('a').text
      link = li.css('a').attr('href').value

      puts "`#{fresh_line}` # #{description} - #{link}"
    end
  end
end
