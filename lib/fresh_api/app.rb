require 'sinatra'
require 'dalli'
require 'open-uri'
require 'fresh_api/directory'

module FreshApi
  class App < Sinatra::Base
    set :cache, Dalli::Client.new

    get '/directory' do
      content_type 'text/plain', :charset => 'utf-8'
      html = open('https://github.com/freshshell/fresh/wiki/Directory')
      directory = Directory.new
      directory.load_github_wiki_page(html)
      directory.entries.map(&:to_s).join("\n")
    end
  end
end
