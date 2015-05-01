# RSpec example to test Sinatra DSL-based applications
# It does not use the spec_helper file that all other 
# examples. That one is designed for modular applications.

require 'bundler'
Bundler.setup
require 'rack/test'
require 'rspec'
require 'json'
require 'yaml'


describe "Given an application directory with a configuration file on the 'config' subdir" do
  def app()
    Sinatra::Application
  end

  Dir.mktmpdir("rack_test") do |tmp_dir|
    ENV['APPDSL'] = tmp_dir
    conf_dir = "#{tmp_dir}/config"
    Dir.mkdir(conf_dir)
    conf = {option1: "it worked!"}.to_yaml
    File.open(File.expand_path("test.yml", conf_dir), 'w') do |f|
      f.write(conf)
    end

    # Required here since the config directory and env var need to 
    # be present at definition time.
    require 'dsl_app'

    describe "and a environnment var pointing to it" do

      describe 'when a DSL-based Sinatra application is created with env_based_config pointing to this env var' do 

        it 'finds the configuration file and makes the keys available through settings' do
          get '/'
          expect(JSON.parse(last_response.body, :symbolize_names => true)).to eql(
            {option1: "it worked!", conf_env: "APPDSL", conf_location: "#{conf_dir}/test.yml"}
          )
        end

      end

    end

  end

end


