#!/usr/bin/env ruby
# Application to test DSL-based Sinatra apps
require 'sinatra'
require 'sinatra/envconf'
require 'json'

set :environment, :test
env_based_config 'APPDSL'


get '/' do
  headers['Content-type'] = 'application/json'
  {option1: settings.option1, conf_env: settings.conf_env, conf_location: settings.conf_location}.to_json
end
