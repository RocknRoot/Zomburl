require 'bundler/setup'
require 'sinatra'
require 'rack/recaptcha'
require 'slim'
require 'data_mapper'
require 'dm-migrations'
require 'json'
# Local conf or lib
require './config/loader'

if Zomburl::has_captcha?
  use Rack::Recaptcha, :public_key  => Zomburl::CAPTCHA_PUBLIC_KEY,
                       :private_key => Zomburl::CAPTCHA_PRIVATE_KEY
  helpers Rack::Recaptcha::Helpers
end

get '/' do
  slim :index
end

post '/' do
  url = params[:url]
  redirect to '/' if url.empty? || url.nil? ||
                  (Zomburl::has_captcha? && !recaptcha_valid?)
@url = Url.hash_url(url)
  @clippy = <<-EOF
    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
            width="110"
            height="14"
            id="clippy" >
    <param name="movie" value="/clippy.swf"/>
    <param name="allowScriptAccess" value="always" />
    <param name="quality" value="high" />
    <param name="scale" value="noscale" />
    <param NAME="FlashVars" value="text=#{@url}">
    <param name="bgcolor" value="#0f0f0f">
    <embed src="/clippy.swf"
           width="110"
           height="14"
           name="clippy"
           quality="high"
           allowScriptAccess="always"
           type="application/x-shockwave-flash"
           pluginspage="http://www.macromedia.com/go/getflashplayer"
           FlashVars="text=#{@url}"
           bgcolor="#0f0f0f"
    />
    </object>
  EOF
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
