Bundler.require :default, :test

require 'spork'

Spork.prefork do
	unless ENV['DRB']
		require 'simplecov'
		SimpleCov.start do
			add_filter "/config"
			add_filter "/spec"
			add_filter "/api"
			add_filter "/app/classes/validators"
		end
	end

	$LOAD_PATH.unshift(File.dirname(__FILE__))

	# require app init file
	require File.expand_path("../../config/application", __FILE__)
end

Spork.each_run do
	# This code will be run each time you run your specs.
	if ENV['DRB']
		require 'simplecov'
		SimpleCov.start do
			add_filter "/config"
		end
	end
end