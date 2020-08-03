require 'sinatra'
require 'yaml/store'
require 'mongo'
require 'mongoid'
require_relative 'sort.rb'

Mongo::Logger.logger.level = ::Logger::FATAL

client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => "votes_db")


@votes = { 'HAM' => 0, 'PIZ' => 0, 'CUR' => 0, 'NOO' => 0 }

# Make it conditional - if the database is not there yet
result = client[:food_votes].insert_many([
  { :num => 1, :name => "Hamburger", :abbr => 'HAM', :votes => 0 },
  { :num => 2, :name => "Pizza", :abbr => 'PIZ', :votes => 0 },
  { :num => 3, :name => "Curry", :abbr => 'CUR', :votes => 0 },
  { :num => 4, :name => "Noodles", :abbr => 'NOO', :votes => 0 }
])

Choices = {
  'HAM' => 'Hamburger',
  'PIZ' => 'Pizza',
  'CUR' => 'Curry',
  'NOO' => 'Noodles',
}

get '/' do
  @title = "Dinner"
  erb :index
end

get '/results' do
  @title = "Your results"

  #@store = YAML::Store.new 'votes.yml'
  #@store.transaction do
    #@sorted_votes = sort_desc({})
  #end
  erb :results
end

post '/cast' do
  @title = "Option chosen:"
  @option = params['vote']

  #@store = YAML::Store.new 'votes.yml'
  #@store.transaction do
    #@store["votes"] ||= {}
    #@store["votes"][@option] ||= 0
    #@store["votes"][@option] += 1
  #end
  @votes[@option] += 1
  client[:food_and_points].insert_one @votes
  client[:food_and_points].update_one({"abb" => @option}, '$set' => {@option => @votes[@option]})
  erb :cast
end
resultsHash = {}
db.getCollection('food_votes').find({}).sort( { votes : -1 } )
