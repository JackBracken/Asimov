require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new do |task|
  task.libs << %w(test lib)
  task.pattern = 'test/test_*.rb'
end

desc 'Run RuboCop in lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
  task.fail_on_error = false
end

task default: :test
