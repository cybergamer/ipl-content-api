require 'rubygems'
require 'bundler/setup'

require File.expand_path('../environment', __FILE__)

Bundler.require :default, ENV['RACK_ENV']

require File.expand_path('../mongoid', __FILE__)