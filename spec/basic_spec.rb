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
      ENV['APP1'] = tmp_dir

      describe "and a configuration file in the config subdirectory" do
        conf = {option1: "it worked!"}.to_yaml
        File.open(File.expand_path("test.yml", conf_dir), 'w') do |f|
          f.write(conf)
        end

        describe 'when the Sinatra application is created with config_env_var pointing to this env_var' do

          class App1 < Sinatra::Base 

            set :environment, :test
            register Sinatra::EnvConf
            config_env_var 'APP1'

            get '/' do
              headers['Content-type'] = 'application/json'
              
              {option1: settings.option1, config_env_var: settings.config_env_var, config_location: settings.config_location}.to_json
            end
          end

          describe App1 do

            it 'finds the configuration file and makes the keys available through settings' do
              get '/'
              expect(JSON.parse(last_response.body, :symbolize_names => true)).to eql(
                {option1: "it worked!", config_env_var: "APP1", config_location: "#{conf_dir}/test.yml"}
              )
            end

          end

        end

      end

    end

  end

end

describe "Given an application directory" do

  Dir.mktmpdir("rack_test") do |tmp_dir|
    conf_dir = "#{tmp_dir}/config"
    Dir.mkdir(conf_dir)

    describe "and a environnment var pointing to it" do
      ENV['APP1'] = tmp_dir

      describe "but no configuration file in the config directory" do

        it "should raise an exception when the application is started" do

          expect {

            class App2 < Sinatra::Base 

              set :environment, :test
              register Sinatra::EnvConf
              config_env_var 'APP1'

              get '/' do
                headers['Content-type'] = 'application/json'
                
                {option1: settings.option1}.to_json
              end
            end

          }.to raise_error(Errno::ENOENT)

        end

      end

    end

  end

end

describe "Given config file in a normal directory" do

  Dir.mktmpdir("rack_test") do |tmp_dir|

    describe "and a environnment var pointing to it using the name ending in _CONFIG_FILE" do
      ENV['APP1_CONFIG_FILE'] = "#{tmp_dir}/.sample.yml"

      conf = {option1: "it worked!"}.to_yaml
      File.open(ENV['APP1_CONFIG_FILE'], 'w') do |f|
        f.write(conf)
      end

      describe 'when the Sinatra application is created with config_env_var pointing to the env prefix' do

        class App3 < Sinatra::Base 

          set :environment, :test
          register Sinatra::EnvConf
          config_env_var 'APP1'

          get '/' do
            headers['Content-type'] = 'application/json'
            
            {option1: settings.option1}.to_json
          end
        end

        describe App3 do

          it 'finds the configuration file and makes the keys available through settings' do
            get '/'
            expect(JSON.parse(last_response.body, :symbolize_names => true)).to eql({option1: "it worked!"})
          end

        end

      end

    end

  end

end
