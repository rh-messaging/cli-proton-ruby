#!/usr/bin/env rake
require 'rake/testtask'

# For verbose output: `rake test TESTOPTS=-v`
# See http://ruby-doc.org/stdlib-2.0.0/libdoc/rake/rdoc/Rake/TestTask.html for more.

task :default => [:test]

desc 'Run unit tests'
Rake::TestTask.new(:test) do |t|
  t.libs << "tests"
  t.test_files = Dir["tests/**/unit_tests_*.rb"].sort
  t.verbose = true
  t.warning = true
end
