#!/usr/bin/env rake
require 'rake/testtask'

# For verbose output: `rake test TESTOPTS=-v`
# See http://ruby-doc.org/stdlib-2.0.0/libdoc/rake/rdoc/Rake/TestTask.html for more.

task :default => [:self_test]

task :test => [:unit_tests, :client_tests]
task :self_test => [:unit_tests, :client_self_tests]

desc 'Run unit tests'
Rake::TestTask.new(:unit_tests) do |t|
  t.libs << "tests"
  t.test_files = Dir["tests/unit/**/unit_tests_*.rb"]
  t.verbose = true
  t.warning = true
end

desc 'Run client tests. Requires an external broker to be running on localhost:5672'
Rake::TestTask.new(:client_tests) do |t|
  t.libs << "tests"
  t.test_files = Dir["tests/client/**/test_*.rb"]
  t.verbose = true
  t.warning = true
end

desc 'Run client tests with a self-started test broker.'
task :client_self_tests do
  broker = IO.popen([RbConfig.ruby,  File.join("bin", "broker.rb"), "" ])
  unless (ready = broker.readline) =~ /^Listening on /
    Process.kill :KILL, broker.pid
    raise "broker failed: #{ready}#{broker.read}"
  end
  Rake::Task[:client_tests].invoke :client_tests
  Process.kill :KILL, broker.pid
end
