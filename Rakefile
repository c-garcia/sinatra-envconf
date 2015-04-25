# @author Cristobal Garcia
# @version 0.1

# Build tasks
require 'bundler/gem_tasks'

# Documentation tasks
task :doc => ['doc:generate']
namespace :doc do
  project_root = File.expand_path(File.join(File.dirname(__FILE__), '.'))
  doc_dir = File.join(project_root,'doc')
  begin
    require 'yard'
    require 'yard/rake/yardoc_task'

    YARD::Rake::YardocTask.new(:generate) do |t|
      t.files   = ['lib/**/*.rb']   # optional
      t.options = ['--main','README.md','--output-dir',doc_dir,
                   '--markup','markdown','--markup-provider','kramdown'] 
    end
  rescue LoadError
    abort "Please, install YARD gem to generate the documentation"
  end

  desc "Remove documentation"
  task :clean do
    rm_r doc_dir if File.exists?(doc_dir)
  end
end

# General testing tasks

# RSpec
namespace :rspec do
  require 'rspec/core/rake_task'
  desc <<-EOF
    Unit testing from the CLI.

    COVERAGE=on enables SimpleCov coverage analysis
    RSPEC_FORMAT=[progress]|documentation|html
    RSPEC_OUT=file to write the report
    RSPEC_COLOR=[y]|n
  EOF
  

  RSpec::Core::RakeTask.new(:term) do |rs|
    rspec_format = ENV['RSPEC_FORMAT']||'progress'
    rspec_color = (ENV['RSPEC_COLOR']||'y') == 'y'
    #rs.ruby_opts = %w(-w )
    rs.rspec_opts = ['--format',rspec_format]
    if rspec_color
      rs.rspec_opts << %w(--tty --color)
    end
    if ENV['RSPEC_OUT']
      rs.rspec_opts << ['--out',ENV['RSPEC_OUT']]
    end
    rs.pattern = 'spec/**/*_spec.rb'
  end

end

task :test => ['rspec:term']

task :default => ['test']

# Misc tasks
namespace :info do
  desc 'List loaded gems (useful to verify bundle exec)'
  task :gemlist do |t|
    Gem.loaded_specs.values.
      map {|x| "#{x.name} #{x.version}"}.each {|x| puts x}
  end
end

