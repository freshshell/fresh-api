require 'nokogiri'
require 'set'
require 'shellwords'

module FreshApi
  class Directory
    attr_accessor :entries

    class Entry
      attr_accessor :code, :description, :url

      def initialize(data)
        data.each do |key, value|
          send "#{key}=", value
        end
      end

      def terms
        terms = Set.new

        tokens = Shellwords.shellsplit self.code.to_s
        if tokens.shift == 'fresh'
          tokens.each do |token|
            if token =~ /^(--[^=]+)(?:=(.+))?/
              option_name, option_value = $1, $2
              terms << option_name
              if option_value
                terms << File.basename(option_value).sub(/^\./, '')
              end
            else
              terms << token
              terms += token.split('/')
            end
          end
        end

        terms += self.description.to_s.split(/\W+/)

        terms.map!(&:downcase)
        terms.to_a
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

    def search(query)
      query_terms = Shellwords.shellsplit(query.to_s).map(&:downcase)
      self.entries.select do |entry|
        query_terms.all? do |query_term|
          entry.terms.any? do |entry_term|
            entry_term.start_with?(query_term)
          end
        end
      end
    end
  end
end
