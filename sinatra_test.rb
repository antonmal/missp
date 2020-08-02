require 'sinatra'
require 'yaml/store'
require_relative 'sort.rb'

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

  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @sorted_votes = sort_desc(@store["votes"])
  end
  
  erb :results
end

post '/cast' do
  @title = "Option chosen:"
  @option = params['vote']

  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store["votes"] ||= {}
    @store["votes"][@option] ||= 0
    @store["votes"][@option] += 1
  end

  erb :cast
end
