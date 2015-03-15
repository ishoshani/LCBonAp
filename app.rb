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
require './models/Day'

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
  @days = Array.new
  (0..6).each do |day|
    current_day = html.css("#menu-items .eni-menu-day-#{day}")
    @meals = Hash.new
    current_day.css("table tr").each do |element|
      if (element["class"] == "always-show-me")
        @meal = element.css("td strong").text
        @meals[@meal] = Array.new
      else
        @meals[@meal].push([element.css(".station strong").text, element.css(".description strong").text])
      end
    end
    @days.push(@meals)
  end
end

def fill_database
  empty_database
  scrape_menu
  @days.each_with_index do |day, index|
    current_day = Day.create(week: DateTime.now, day: index)
    day.each do |key, array|
      meal = current_day.meals.create(name: key)
      array.each do |station, description|
        meal.items.create(station: station.capitalize, description: "#{description.capitalize}.", votes: 0)
      end
    end
  end
end


def empty_database
  Day.all.each do |day|
    day.destroy
  end
end


get '/' do
  @meals = Day.find_by(day: Date.today.cwday).meals
  @cookie = cookies
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

