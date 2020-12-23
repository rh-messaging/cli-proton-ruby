#!/usr/bin/env bash

# project directory is mounted under /mnt
PROJECT="/mnt"

cd /
gem install rubygems-update
sudo update_rubygems
gem install rake
gem install minitest
gem install qpid-proton/build/ruby/gem/qpid_proton-*.gem
cd $PROJECT/tests
rake unit_tests || rake --trace unit_tests TESTOPTS="-v"
# rake client_tests
