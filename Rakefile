require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :console do
  require "irb"
  require "irb/completion"
  require "platform161/client"
  ARGV.clear
  IRB.start
end
