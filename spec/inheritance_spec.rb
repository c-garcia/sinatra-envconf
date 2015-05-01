require 'bundler'
Bundler.setup
require 'sinatra/base'
require 'sinatra/envconf'
require 'spec_helper'
require 'json'
require 'yaml'


describe "Given an application directory" do

  Dir.mktmpdir("rack_test") do |tmp_dir|
    conf_dir = "#{tmp_dir}/config"
    Dir.mkdir(conf_dir)

    describe "and a environnment var pointing to it" do
      ENV['APPC'] = tmp_dir

      describe "and a configuration file in the config subdirectory" do
        conf = {option1: "it worked!"}.to_yaml
        File.open(File.expand_path("test.yml", conf_dir), 'w') do |f|
          f.write(conf)
        end

        describe 'when a Sinatra application is created with config_env_var pointing to this env_var and the SUT inherits from it' do

          class AppB < Sinatra::Base

            set :environment, :test
            register Sinatra::EnvConf

            config_env_var 'APPC'
          end

          class App < AppB
            get '/' do
              headers['Content-type'] = 'application/json'
              
              {option1: settings.option1, config_env_var: settings.config_env_var, config_location: settings.config_location}.to_json
            end
          end

          describe App do
            it 'finds the configuration file and makes the keys available through settings' do
              get '/'
              expect(JSON.parse(last_response.body, :symbolize_names => true)).to eql(
                {option1: "it worked!", config_env_var: "APPC", config_location: "#{conf_dir}/test.yml"}
              )
            end
          end

        end

      end

    end

  end

end

