ENV['RACK_ENV'] ||= 'development'
require 'bundler/setup'
$: << 'lib'

require 'fresh_api/app'
run FreshApi::App
