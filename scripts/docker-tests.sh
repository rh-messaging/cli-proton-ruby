#!/usr/bin/env bash

# project directory is mounted under /mnt
PROJECT="/mnt"

gem install minitest
gem install qpid-proton/proton-c/bindings/ruby/gem/qpid_proton-0.21.0.gem
cd $PROJECT/tests
ruby unit_tests.rb
