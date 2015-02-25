# Logic for BonApp
require 'rubygems'
require 'bundler/setup'
Bundler.require

get '/' do
	erb :index
end

