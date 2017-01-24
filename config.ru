require './config/environment.rb'

use Rack::Static, :urls => ['/css', '/js'], :root => 'public'
use Rack::MethodOverride
use GetTo24Controller
run ApplicationController
