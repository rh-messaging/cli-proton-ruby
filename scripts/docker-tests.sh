#!/usr/bin/env bash

# project directory is mounted under /mnt
PROJECT="/mnt"

yum install -y centos-release-scl
yum install -y rh-ruby24 rh-ruby24-ruby-devel
source scl_source enable rh-ruby24

cd /
gem install rake
gem install minitest
gem install qpid-proton/proton-c/bindings/ruby/gem/qpid_proton-*.gem
cd $PROJECT/tests
rake test
