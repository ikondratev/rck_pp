require "rubygems"
require "rake"

desc "Run specs"
task default: %i[rubocop]

require 'rubocop/rake_task'
RuboCop::RakeTask.new do |task|
  task.fail_on_error = true
  task.requires << 'rubocop-rake'
end