# Logic for BonApp
require 'rubygems'
require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require 'date'
Bundler.require

MENU_URL = "http://legacy.cafebonappetit.com/print-menu/cafe/150/menu/"

def scrape_bon
  html = Nokogiri::HTML(open(MENU_URL))
  today = html.css("#menu-items .eni-menu-day-#{Date.today.cwday}")
  @items = today.css('.station strong').zip(today.css(".description strong"))
end

get '/' do
  scrape_bon
	erb :index
end

