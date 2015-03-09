# Logic for BonApp
require 'rubygems'
require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require 'date'
Bundler.require

MENU_URL = "http://legacy.cafebonappetit.com/print-menu/cafe/150/menu/"

def scrape_menu
  html = Nokogiri::HTML(open(MENU_URL))
  if Date.today.cwday == 7 # Fix for sundays.
    @today = html.css("#menu-items .eni-menu-day-0")
  else
    @today = html.css("#menu-items .eni-menu-day-#{Date.today.cwday}")
  end
  @meals = Hash.new

  @today.css(".always-show-me td strong").each do |meal|
    @meals[meal.text] = Array.new
  end

  @today.css("table tr").each do |element|
    if (element["class"] == "always-show-me")
      @meal = element.css("td strong").text
    else
      @meals[@meal].push([element.css(".station strong").text, element.css(".description strong").text])
    end
  end
end

get '/' do
  scrape_menu
	erb :index
end

