# Zomburl

Fast URL Shortening service

* Version : 1.0

Code is free, so if you're paranoid, you can install it at home or in that little private internet
of yours. Or just participate to the development. Fork us !

## Requirements

You need some dependencies like ruby (not 1.8.7 !), rubygems on your system.

Tested with Ruby :

* 1.9.2
* 1.9.3

## Installation

We asume that you already have a web server capable of running Rack applications (keywords
: Apache, nginx, mod_passenger, ...).

    $ git clone git://github.com/RocknRoot/Zomburl.git zomburl
    $ cd zomburl
    $ gem install bundle
    $ bundle install
    $ ruby main.rb

### Troubleshooting

If you have a problem during mysql2 gem installation (On Debian/Ubuntu):

    sudo apt-get install libmysqlclient-dev

If you change the database, you need to configure the corresponding settings in config/db.rb file. (sqlite3 by default)

If you have problems to run Zomburl (Database connect error, read only db, etc.), ensure that the db directory is owned by corresponding http user (www, www-data, nobody, etc.).


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
