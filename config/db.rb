DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/development.db")
# Require models  files here
require './model/url'
# End of model definitions
DataMapper.finalize
DataMapper.auto_upgrade!
