require "sinatra"
require "sinatra/cookies"
require 'rubygems'
require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require 'date'
require 'json'
Bundler.require
require './models/Item'
require './models/Meal'

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
      station = element.css(".station strong").text.capitalize
      # Removes any tabs, line-breaks, and splits the title from the description
      item_text = element.css(".description").text.gsub("\t", "").gsub("\n", "").split('  |  ')
      title = item_text.first.capitalize
      description = item_text.last.capitalize + "."
      if item_text.size == 1 # If there is no description
        description = ""
      end
      @meals[@meal].push([station, title, description])
    end
  end
end

def fill_database
  Meal.destroy_all
  scrape_menu
  @meals.each do |key, array|
    meal = Meal.create(name: key)
    array.each do |station, title, description|
      meal.items.create(station: station, title: title, description: description, votes: 0)
    end
  end
end

get '/' do
  @meals = Meal.all
  @cookie = cookies
  puts DateTime.tomorrow.midnight
  erb :index
end

post '/' do
  @item = Item.find_by(id: params[:id])
  if cookies[params[:id]].nil?
    if params[:vote] == "upvote"
      @item.increment!(:votes)
    elsif params[:vote] == "downvote"
      @item.decrement!(:votes)
    end
    response.set_cookie(params[:id],
                        :value => params[:vote],
                        :expires => DateTime.tomorrow.midnight)
  end
  content_type :json
  @item.votes.to_json
end

