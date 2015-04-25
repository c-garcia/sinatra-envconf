Sinatra extension to allow to locate the application configuration file in YAML format via an
environment variable. 

# Goals

* Make easy to test multiple configurations
* Deploy sinatra apps as gems keeping their configuration intact in directories outside of the 
  `rubygems` control.

# How to use it

First, we should create a directory to hold the configuration, as an example `/etc/app1`. On it, we should put
a `config` directory which can contain configuration files with the same name of the RACK environment. For instance:

  * `production.yml`
  * `development.yml`
  * `test.yml`

Second, we create the config file, 

    message: "Hello, world!"

Once we get the application directory - which contains the configuration file, 
we should decide which environment variable will point to it. For the sake of clarity, let's choose 
`APP1`. Now we can code our application as per the below:


    require 'sinatra/base'
    require 'sinatra/envconf'
    
    class MyApp < Sinatra::Base

      register Sinatra::EnvConf
      env_based_conf 'APP1'
      get '/' do
        headers['Content-type'] = 'application/json'
        {message: settings.message}.to_json
      end
    end

Also, if a var with the `_CONFIG_FILE` suffix is found, the configuration file will be looked up
directly through there.

# License

Copyright 2015 Crist&oacute;bal Garc&iacute;a

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 .

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
