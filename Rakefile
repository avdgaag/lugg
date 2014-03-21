require 'bundler/gem_tasks'

desc 'Default: run specs.'
task default: %i[spec rubocop doc]

require 'rspec/core/rake_task'
desc 'Run specs'
RSpec::Core::RakeTask.new

require 'yard'
desc 'Generate API docs'
YARD::Rake::YardocTask.new :doc

require 'rubocop/rake_task'
desc 'Check source code against Ruby style guide'
Rubocop::RakeTask.new

desc 'Start Irb with Lugg pre-loaded'
task :console do
  require 'irb'
  require 'irb/completion'
  require 'lugg'
  ARGV.clear
  IRB.start
end
