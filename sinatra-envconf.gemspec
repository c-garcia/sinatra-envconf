# encoding: utf-8
$:.push(File.expand_path('../lib',__FILE__))

require 'sinatra/envconf/version'

Gem::Specification.new do |s|
  s.name        = 'sinatra-envconf'
  s.version     = Sinatra::EnvConf::VERSION
  s.licenses    = ['Apache License 2.0']
  s.summary     = 'Sinatra Extension to load different config files depending on env vars or the environment' 
  s.description = "This gem enables to define, via an environment variable, the directory containing the application "
  s.description += "configuration. The file, with the same name as the RACK environment, is parsed as YAML and all "
  s.description += "its keys are attached to the settings objects via 'set'."
  s.authors     = ["Cristobal Garcia"]
  s.email       = 'cristobal.garcia@obliquo.eu'
  s.files       = ["README.md", "LICENSE.txt", "Gemfile"]
  s.files      += Dir['lib/**/*.rb']
  s.homepage    = 'https://github.com/c-garcia/sinatra-envconf'

  s.add_runtime_dependency 'sinatra', '~>1.4'
  s.add_development_dependency 'bundler', '~>1.9'

end
