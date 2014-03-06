# Tasks
namespace :staypuft do
  namespace :example do
    desc 'Example Task'
    task :task => :environment do
      # Task goes here
    end
  end
end

# Tests
namespace :test do
  desc "Test Staypuft"
  Rake::TestTask.new(:staypuft) do |t|
    test_dir = File.join(File.dirname(__FILE__), '../..', 'test')
    t.libs << ["test",test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
  end
end

Rake::Task[:test].enhance do
  Rake::Task['test:staypuft'].invoke
end

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:setup')
  Rake::Task["jenkins:unit"].enhance do
    Rake::Task['test:staypuft'].invoke
  end
end
