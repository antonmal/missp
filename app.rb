#!/usr/bin/ruby

require 'mongo'
require 'mongoid'
require 'sinatra'
require_relative 'exercise.rb'
require_relative 'game.rb'
require_relative 'misspellings.rb'


Mongo::Logger.logger.level = ::Logger::FATAL

$client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => "missp_db")

# APP

get '/' do
  @title = "Dinner"
  erb :index
end

get '/results' do
  @title = "Your results"
  @votes = {
    'HAM' => 1,
    'PIZ' => 4,
    'CUR' => 8,
    'NOO' => 5,
  }
  erb :results
end

post '/cast' do
  @title = "Option chosen:"
  @option = params['vote']
  erb :cast
end


ex1 = Exercise.new

ex1.show_exercise

$client.close
