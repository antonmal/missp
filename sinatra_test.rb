require 'sinatra'
require 'yaml/store'

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
  @votes = {
    'HAM' => 0,
    'PIZ' => 0,
    'CUR' => 0,
    'NOO' => 0,
  }
  erb :results
end

post '/cast' do
  @title = "Option chosen:"
  @option = params['vote']
  erb :cast
end
