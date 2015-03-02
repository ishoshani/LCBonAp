# Logic for BonApp
require 'rubygems'
require 'bundler/setup'
require 'open-uri'
Bundler.require

get '/' do
	erb :index
	url='http://lewisandclark.cafebonappetit.com/'
	data=Nokogiri::HTML(open(url))
	meals=data.css('daypart-menu')
end

