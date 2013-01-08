class Url
  include DataMapper::Resource
  property :id,           Serial
  property :base_32_id,   String, :required => true
  property :real_url,     Text, :required => true
  property :created_at,   DateTime
  property :updated_at,   DateTime

  validates_presence_of :real_url, :base_32_id

  def self.hash_url(url)
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
    "#{Zomburl::SERVER_URL}/#{base_32}"
  end

end ## Url
