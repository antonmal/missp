require 'sinatra'
require 'yaml/store'
require 'mongo'
require 'mongoid'
require_relative 'sort.rb'

Mongo::Logger.logger.level = ::Logger::FATAL

client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => "votes_db")

db = client.database

coll = client[:food_votes]

@votes = { 'HAM' => 0, 'PIZ' => 0, 'CUR' => 0, 'NOO' => 0 }

# Make it conditional - if the database is not there yet


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
coll.update_one({:abbr => @option}, {$inc => {:votes => 1}})
  erb :cast
end

#puts @sorted_votes
coll.find.sort(:votes => -1)
client.close
