ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

require 'sinatra/reloader' if Sinatra::Base.development?

class FreshSearchApi < Sinatra::Base
  get '/' do
    #
  end
end
