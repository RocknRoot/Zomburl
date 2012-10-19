require 'bundler/setup'
require 'sinatra'
require 'slim'
require 'data_mapper'
require 'dm-migrations'
# Local conf or lib
require './config/loader'

get '/' do
  slim :index
end

post '/' do
  url = params[:url]
  redirect to '/' if url.empty?
  url = "http://#{url}" if url !~ /http:\/\//
  length = Url.all.length
  if length < Zomburl::MAX_URL
    base_32 = length.to_32
    Url.create(real_url: url, base_32_id: base_32)
  else
    url_to_replace = Url.all(order: [ :updated_at.asc ]).first
    base_32 = url_to_replace.base_32_id
    url_to_replace.update(real_url: url)
  end
  @url = "#{Zomburl::SERVER_URL}/#{base_32}"
  slim :show
end

get '/:id' do
  base_32_id = params[:id]
  url = Url.first(:base_32_id => base_32_id)
  final = url ? url.real_url : Zomburl::SERVER_URL
  redirect to final
end
