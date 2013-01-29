require 'rack'
require 'rack/contrib'
require 'rack/timeout'

use Rack::Timeout
Rack::Timeout.timeout = 2

use Rack::JSONP

require File.expand_path('../config/application', __FILE__)
run IPL::Content::API