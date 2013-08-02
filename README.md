# Zomburl

Fast URL Shortening service

* Public install : http://cadav.re
* Homepage : http://wiki.rocknroot.org/Zomburl
* Version : 1.0

Code is free, so if you're paranoid, you can install it at home or in that little private internet
of yours. Or just participate to the development. Fork us !

## Requirements

You need some dependencies like ruby, rubygems on your system.

Tested with Ruby :

* 1.8.7
* 1.9.2
* 1.9.3

## Installation

We asume that you already have a web server capable of running Rack applications (keywords
: Apache, nginx, mod_passenger, ...).

    $ git clone git://github.com/RocknRoot/Zomburl.git zomburl
    $ cd zomburl
    $ gem install bundler
    $ bundle install

### Troubleshooting

If you have a problem during mysql2 gem installation (On Debian/Ubuntu):

    sudo apt-get install libmysqlclient-dev

If you change the database, you need to configure the corresponding settings in config/db.rb file. (sqlite3 by default)

If you have problems to run Zomburl (Database connect error, read only db, etc.), ensure that the db directory is owned by corresponding http user (www, www-data, nobody, etc.).

## Configuration

### Database adapter

Zomburl use sqlite3 by default.

To use postgresql or mysql, uncomment theses lines (according to your choice) in your Gemfile:

```ruby
# Mysql
gem 'mysql2'
gem 'dm-mysql-adapter'
# Postgresql
gem 'pg'
gem 'dm-postgres-adapter'
```

If you change your db adapter, go to config/db.rb file and change informations according to your choice:

```ruby
# MySQL connection:
DataMapper.setup(:default, 'mysql://user:password@hostname/database')
```

or

```ruby
# Postgres connection:
DataMapper.setup(:default, 'postgres://user:password@hostname/database')
```

Don't forget to comment old sqlite3 line.

### Common configuration

Moreover, look at config directory. You have to fill infos located in app.rb file.

Needed informations are:

* HASH - allow you to hash your shortened url (default: false)
* SERVER_URL - this will be the http accessed domain to get final url.
* DB_NAME - Database name located in db directory.

### Optionnal configuration settings

You can setup recaptcha plugin for your Zomburl app (you need to get a account on recaptcha.net)

In app.rb, you can add:

* CAPTCHA_PUBLIC_KEY = 'your_pub_key_here'
* CAPTCHA_PRIVATE_KEY = 'your_priv_key_here'

### Change your configuration

In Zomburl app directory:

    $ mv config/app.rb.example config/app.rb
    $ vi config/app.rb # Edit your configuration file with needed informations

You can change MAX_URL too if you want store fewer informations.

## Running Zomburl

If you're in development mode, you can test zomburl with embedded web server with:

    $ ruby main.rb # assuming you're in Zomburl app directory

Or with passenger (on nginx), for your (simple) vhost configuration:

    server {
        listen   80;
        server_name  fucking-great.url.com;
        root  /var/www/zomburl_app_directory/public;
        passenger_enabled on;
        passenger_base_uri /;
    }

NOTE: This example ISN'T secure (no SSL).

## Need help ?

Add an issue on github ! ;)

## License

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
       Version 2, December 2004

Copyright (C) 2012 Thibaut Deloffre

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document, and changing it is allowed as long
as the name is changed.

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

0. You just DO WHAT THE FUCK YOU WANT TO.
