# This task is called by the Heroku scheduler add-on
desc 'Scrape freshshell/fresh/wiki/Directory'
task :scrape do
  require 'nokogiri'
  require 'open-uri'

  doc = Nokogiri::HTML(open('https://github.com/freshshell/fresh/wiki/Directory'))
  doc.css('#wiki-body .markdown-body li').each do |li|
    fresh_line = li.css('code').text
    description = li.css('a').text
    link = li.css('a').attr('href').value

    puts "`#{fresh_line}` # #{description} - #{link}"
  end
end
