require 'yaml'

path = File.join(File.dirname(__FILE__), 'mongoid.yml')
config = YAML::load(ERB.new(IO.read(path)).result)["#{ENV['RACK_ENV']}"]
host = config['host']
port = config['port'].to_i
database = config['database']

Mongoid.configure do |config|
  config.skip_version_check = true
  config.master = Mongo::Connection.new(host, port).db(database)
end