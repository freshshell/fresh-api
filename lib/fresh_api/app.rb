require 'sinatra'
require 'dalli'
require 'open-uri'
require 'fresh_api/directory'

module FreshApi
  class App < Sinatra::Base
    set :cache, Dalli::Client.new

    get '/directory' do
      content_type 'text/plain', :charset => 'utf-8'
      directory.search(params[:q]).map(&:to_s).join("\n")
    end

    private

    def directory
      html = settings.cache.get 'directory-html'
      directory = Directory.new
      if html
        directory.load_github_wiki_page(html)
      else
        html = URI.parse('https://github.com/freshshell/fresh/wiki/Directory').read
        directory.load_github_wiki_page(html)
        settings.cache.set 'directory-html', html, 300
      end
      directory
    end
  end
end
