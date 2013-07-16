require 'mhash'

class Url
  include DataMapper::Resource
  property :id,           Serial
  property :base_32_id,   String,   :required => true
  property :real_url,     Text,     :required => true
  property :hashed,       Boolean,  :default => false
  property :created_at,   DateTime
  property :updated_at,   DateTime

  validates_presence_of :real_url, :base_32_id

  def self.hash_url(url)
    url = "http://#{url}" if url !~ /^http/
    object = Url.first(:real_url => url)
    if object
      base_32 = object.base_32_id
    else
      length = Url.all.length
      if length < Zomburl::MAX_URL
        base_32 = length.to_32
        if Zomburl::HASH
          base_32 = base_32.to_crc
          check = Url.first(:base_32_id => base_32)
          base_32 = base_32.to_crc if check
        end
        object = Url.create(:real_url => url,
                            :base_32_id => base_32,
                            :hashed => Zomburl::HASH)
      else
        url_to_replace = Url.all(:order => [ :updated_at.asc ]).first
        base_32 = url_to_replace.base_32_id
        if Zomburl::HASH && !url_to_replace.hashed
          base_32 = base_32.to_crc
          check = Url.first(:base_32_id => base_32)
          base_32 = base_32.to_crc if check
        end
        url_to_replace.update(:real_url => url,
                              :base_32_id => base_32,
                              :hashed => Zomburl::HASH)
      end
    end
    "#{Zomburl::SERVER_URL}/#{base_32}"
  end

end ## Url
