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
