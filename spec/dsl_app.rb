#!/usr/bin/env ruby
# Application to test DSL-based Sinatra apps
require 'sinatra'
require 'sinatra/envconf'
require 'json'

set :environment, :test
config_env_var 'APPDSL'


get '/' do
  headers['Content-type'] = 'application/json'
  {option1: settings.option1, config_env_var: settings.config_env_var, config_location: settings.config_location}.to_json
end
