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

__END__
@@layout
doctype html
html
  head
    meta charset="utf-8"
    title Zomburl
    link href='http://fonts.googleapis.com/css?family=Jolly+Lodger' rel='stylesheet' type='text/css'
    link rel="stylesheet" href="stylesheets/application.css"
  body
     div style="margin-left: 35%; margin-top: 12%; width: 500px; text-align:center;"
      img src="images/zombie.png"
      h1 ZOMBURL
      == yield
@@index
form action="/" method="POST"
  label http://
  input type="text" name="url"
  br
  br
  input.button type="submit" value="Zomburl !"
@@show
== @url
