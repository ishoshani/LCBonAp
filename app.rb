# Logic for BonApp
require 'rubygems'
require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
Bundler.require

MENU_URL = "http://legacy.cafebonappetit.com/print-menu/cafe/150/menu/74066/days/today/"

def scrape_bon
  html = Nokogiri::HTML(open(MENU_URL))
  @items = html.css(".station strong").zip(html.css(".description strong"))
end

get '/' do
  scrape_bon
	erb :index
end

