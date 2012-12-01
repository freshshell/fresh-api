require 'fresh_api/directory'

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
      let(:options) { {:description => 'foo-bar, baz'} }
      its(:terms) { should =~ %w[foo bar baz] }
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
end
