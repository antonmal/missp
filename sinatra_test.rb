require 'sinatra'
require 'yaml/store'
require 'mongo'
require 'mongoid'
require_relative 'sort.rb'

Mongo::Logger.logger.level = ::Logger::FATAL

client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => "votes_db")
$coll = client[:food_votes]


get '/' do
  @title = "Dinner"
  @food_options = $coll.find.to_a

  erb :index
end

post '/cast' do
  @title = "Option chosen:"
  option = params['vote']
  $coll.update_one( { abbr: option }, { "$inc": { votes: 1 } } )
  @chosen_food = $coll.find( { abbr: option } ).to_a[0]

  erb :cast
end

get '/results' do
  @title = "Your results"
  @sorted_votes = $coll.find.sort( { votes: -1 } )

  erb :results
end

client.close
