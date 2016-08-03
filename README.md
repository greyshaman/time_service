# time_service 
This is a sinatra application which is provide simple time service
It response on GET request /time and show current UTC time

HOW To setup
* 1. git clone 
* 2. gem install sinatra timezone

if you want start multithread web server like thin then do gem install thin. You can use any other multithread implementation.

START WEB SERVER (single thread)
ruby time_service.rb

or START WEB SERVER (multi thread)
thin --threaded -R config.ru start

