Gem::Specification.new do |s|
  s.name        = 'sinatra-envconf'
  s.version     = '0.1.0'
  s.licenses    = ['Apache License 2.0']
  s.summary     = 'Sinatra Extension to load different config files depending on env vars or the environment' 
  s.description = ""
  s.authors     = ["Cristobal Garcia"]
  s.email       = 'cristobal.garcia@obliquo.eu'
  s.files       = ["README.md", "LICENSE.txt", "Gemfile"]
  s.files      += Dir['lib/**/*.rb']
  s.homepage    = 'https://github.com/c-garcia/sinatra-envconf'

  s.add_runtime_dependency 'sinatra', '~>1.4'
  s.add_runtime_dependency 'bundler', '~>1.9'

  # General 
  s.add_development_dependency 'pry', '~>0.10'
  s.add_development_dependency 'rake', '~>10.4'

  # Testing
  s.add_development_dependency 'rspec-core', '~>3.2'
  s.add_development_dependency 'rspec-expectations', '~>3.2'
  s.add_development_dependency 'rspec-mocks', '~>3.2'
  s.add_development_dependency 'rack-test', '~>0.6'

  # Documentation
  s.add_development_dependency 'yard', '~>0.8'
  s.add_development_dependency 'kramdown', '~>1.6'
end
