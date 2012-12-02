require 'fresh_api/directory'
require 'ostruct'

describe FreshApi::Directory::Entry do
  describe '#terms' do
    subject { described_class.new options }

    describe 'fresh code' do
      describe 'repo and path' do
        let(:options) { {:code => 'fresh jasoncodes/dotfiles aliases/git.sh'} }
        its(:terms) { should =~ %w[jasoncodes/dotfiles jasoncodes dotfiles aliases/git.sh aliases git.sh] }
      end

      describe 'options' do
        let(:options) { {:code => 'fresh --file=~/.pryrc --bin'} }
        its(:terms) { should =~ %w[--file pryrc --bin] }
      end
    end

    describe 'description' do
      let(:options) { {:description => 'foo-bar, baz (zsh)'} }
      its(:terms) { should =~ %w[foo bar baz zsh] }
    end

    describe 'url' do
      let(:options) { {:url => 'https://github.com/freshshell/dotfiles'} }
      its(:terms) { should =~ %w[] }
    end

    describe 'unique lowercase terms' do
      let(:options) { {:code => 'fresh FOO BAR BAZ', :description => 'Foo Bar'} }
      its(:terms) { should =~ %w[foo bar baz] }
    end
  end

  describe '#search' do
    def entry(*terms)
      OpenStruct.new :terms => terms
    end

    let(:foo) { entry 'foo' }
    let(:bar) { entry 'bar' }
    let(:baz) { entry 'baz' }
    let(:foo_bar) { entry 'foo', 'bar' }

    let :directory do
      FreshApi::Directory.new.tap do |directory|
        directory.entries = [foo, bar, baz, foo_bar]
      end
    end

    it 'matches all entries with no search term' do
      directory.search(nil).should =~ [foo, bar, baz, foo_bar]
    end

    it 'matches entries with a single term' do
      directory.search('foo').should =~ [foo, foo_bar]
    end

    it 'matches entries with all entered terms' do
      directory.search('foo bar').should =~ [foo_bar]
    end

    it 'matches entries by prefix' do
      directory.search('ba').should =~ [bar, baz, foo_bar]
    end

    it 'does not match entries by suffix' do
      directory.search('ar').should =~ []
    end
  end
end
