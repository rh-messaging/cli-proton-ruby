#!/usr/bin/env rake
require 'rake/testtask'

# For verbose output: `rake test TESTOPTS=-v`
# See http://ruby-doc.org/stdlib-2.0.0/libdoc/rake/rdoc/Rake/TestTask.html for more.

task :default => [:test]

task :test => [:unit_tests, :client_tests]

desc 'Run unit tests'
Rake::TestTask.new(:unit_tests) do |t|
  t.libs << "tests"
  t.test_files = Dir["tests/unit/**/unit_tests_*.rb"]
  t.verbose = true
  t.warning = true
end

desc 'Run client tests. Requires a broker running on localhost:5672'
Rake::TestTask.new(:client_tests) do |t|
  t.libs << "tests"
  t.test_files = Dir["tests/client/**/test_*.rb"]
  t.verbose = true
  t.warning = true
end
