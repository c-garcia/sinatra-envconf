require 'yaml'
require 'sinatra/base'

module Sinatra
  # Module for enabling us to define the application configuration in a yaml file 
  # that will be located with the help of an environment variable whose name will
  # be defined in the Sinatra app.
  #
  # As an example, if we use `env_based_conf MY_APP`:
  #
  # 1. It will try to find, parse and create settings for a file pointed by `MY_APP_CONF_FILE`.
  #   If the variable does not exist
  # 1. It will try to find, parse and create settings for a file named as the environment plus
  #   the .yml extension located in `MY_APP/config`.
  #
  # Additionally, the settings `conf_env` and `conf_location` will be created pointing to the
  # environment variable name and the resolved file.
  module EnvConf
    private

    # Returns the configuration file location given the name of 
    # an environment variable.
    #
    # @param env_var [String] the environment variable name
    # @return [String] the configuration file location
    def config_file_location(env_var)

      direct_config = "#{env_var}_CONFIG_FILE"

      if ENV[direct_config]
        return ENV[direct_config]
      end

      config_dir = File.expand_path("config", ENV[env_var] || '.' )

      File.expand_path("#{String(settings.environment)}.yml", config_dir)

    end

    public
      
    # Method that will be exported to the Sinatra app. It creates a setting
    # for every key found in the YAML file plus conf_env and conf_location
    # as explained above.
    #
    # @param env_var [String] the environment variable name
    # return [NilClass] nothing
    # @raise [Exception] any exception when reading or processing the yaml
    #   file
    def env_based_config(env_var)

      set :conf_env, env_var

      cfg_location = config_file_location(env_var)
      
      set :conf_location, cfg_location
      
      YAML.load_file(cfg_location).each do |k,v|
        opt = k.to_sym
        opt_val = v
        set opt, opt_val
      end
      nil

    rescue StandardError => e
      $stderr.puts "error when accessing config file #{e.message}" if logging?
      raise e
    end
    
  end
  register EnvConf
  #Delegator.delegate :env_based_config
end

