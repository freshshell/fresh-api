# This task is called by the Heroku scheduler add-on
desc 'Scrape freshshell/fresh/wiki/Directory'
task :scrape do
  require './fresh_search_api.rb'
  FreshSearchApi.scrape
end
