#!/usr/bin/ruby

require 'mongo'
require 'mongoid'
require 'sinatra'
require_relative 'exercise.rb'
require_relative 'game.rb'
require_relative 'misspellings.rb'


#Connect to DB
Mongo::Logger.logger.level = ::Logger::FATAL
$client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => "missp_db")
$coll = $client[:words_and_missp]


get '/' do
  @title = "Misspelling Game"

  erb :index
end

post '/question' do
  @title = "Question number #{}"
  @exercise = Exercise.new()
  @answer_variants = @exercise.exercise_array
  erb :question
end

post '/cast' do
  @variant_chosen = params['word']
end

#Close DB connection
$client.close
