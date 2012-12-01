require 'nokogiri'

module FreshApi
  class Directory
    attr_reader :entries

    class Entry
      attr_accessor :code, :description, :url

      def initialize(data)
        data.each do |key, value|
          send "#{key}=", value
        end
      end

      def to_s
        "`#{code}` # #{description} - #{url}"
      end
    end

    def load_github_wiki_page(html)
      doc = Nokogiri::HTML(html)
      @entries = doc.css('#wiki-body .markdown-body li').map do |li|
        Entry.new(
          :code => li.css('code').text,
          :description => li.css('a').text,
          :url => li.css('a').attr('href').value
        )
      end
      raise "No entries found." if @entries.empty?
    end
  end
end
