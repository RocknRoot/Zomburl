class Url
  include DataMapper::Resource
  property :id,           Serial
  property :base_32_id,   String, :required => true
  property :real_url,     String, :required => true
  property :created_at,   DateTime
  property :updated_at,   DateTime

  validates_presence_of :real_url, :base_32_id
end
