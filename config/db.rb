DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/#{Zomburl::DB_NAME}")

# MySQL connection:
#DataMapper.setup(:default, 'mysql://user:password@hostname/database')

# Postgres connection:
#DataMapper.setup(:default, 'postgres://user:password@hostname/database')

# Require models  files here
require './model/url'
# End of model definitions
DataMapper.finalize
DataMapper.auto_upgrade!
