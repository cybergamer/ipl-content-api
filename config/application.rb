$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'
Dir[File.expand_path('../../app/**/*.rb', __FILE__), File.expand_path('../../api/v2/*.rb', __FILE__), File.expand_path('../../api/api_v*.rb', __FILE__)].each do |f|
  require f
end

require 'api'