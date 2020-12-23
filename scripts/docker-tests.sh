#!/usr/bin/env bash

# project directory is mounted under /mnt
PROJECT="/mnt"

cd /
gem install rubygems-update -v 2.7.11
update_rubygems
gem install rake -v 12.3.3
gem install minitest -v 5.12.0
gem install qpid-proton/build/ruby/gem/qpid_proton-*.gem
cd $PROJECT/tests
rake unit_tests || rake --trace unit_tests TESTOPTS="-v"
# rake client_tests
