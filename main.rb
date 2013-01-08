require 'bundler/setup'
require 'sinatra'
require 'slim'
require 'data_mapper'
require 'dm-migrations'
require 'json'
# Local conf or lib
require './config/loader'

get '/' do
  slim :index
end

post '/' do
  url = params[:url]
  redirect to '/' if url.empty? || url.nil?
  @url = Url.hash_url(url)
  slim :show
end

get '/:id' do
  base_32_id = params[:id]
  url = Url.first(:base_32_id => base_32_id)
  final = url ? url.real_url : Zomburl::SERVER_URL
  redirect to final
end

post '/get' do
  url = params[:url]
  @url = ((url.empty? || url.nil?) ? "" : Url.hash_url(url))
  @url.to_json
end
