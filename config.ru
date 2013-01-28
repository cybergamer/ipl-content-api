require 'rack/timeout'
use Rack::Timeout
Rack::Timeout.timeout = 2

require File.expand_path('../config/application', __FILE__)
run IPL::Content::API