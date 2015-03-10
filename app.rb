# Logic for BonApp
require 'rubygems'
require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require 'date'
require 'json'
Bundler.require
require './models/MenuItem'

if ENV['DATABASE_URL']
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
  ActiveRecord::Base.establish_connection(
    :adapter  => 'sqlite3',
    :database => 'db/development.db',
    :encoding => 'utf8'
    )
end

MENU_URL = "http://legacy.cafebonappetit.com/print-menu/cafe/150/menu/"

def scrape_menu
  html = Nokogiri::HTML(open(MENU_URL))
  today_cwday = Date.today.cwday
  if today_cwday == 7 # Fix for sundays.
    today_cwday = 0   
  end
  today = html.css("#menu-items .eni-menu-day-#{today_cwday}")
  @meals = Hash.new

  today.css("table tr").each do |element|
    if (element["class"] == "always-show-me")
      @meal = element.css("td strong").text
      @meals[@meal] = Array.new
    else
      @meals[@meal].push([element.css(".station strong").text, element.css(".description strong").text])
    end
  end
end

get '/' do
  scrape_menu
	erb :index
end

get '/:item' do
  @item = MenuItem.find_by(id: params[:item])
  erb :item_show
end

post '/' do
  @item = MenuItem.find_by(id: params[:id])
  puts JSON.pretty_generate params
  if params[:vote] == '+1'
    @item.increment!(:votes)
  elsif params[:vote] == '-1'
    @item.decrement!(:votes)
  end
  redirect "/#{params[:id]}"
end

