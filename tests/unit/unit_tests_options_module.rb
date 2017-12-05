#!/usr/bin/env ruby
#--
# Copyright 2017 Red Hat Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#++

require 'minitest/autorun'

# BasicOptionParser unit tests
load 'options/unit_tests_basic_option_parser.rb'
# ConnectorOptionParser unit tests
load 'options/unit_tests_connector_option_parser.rb'
# SRCommonOptionParser unit tests
load 'options/unit_tests_sr_common_option_parser.rb'
# SenderOptionParser unit tests
load 'options/unit_tests_sender_option_parser.rb'
# ReceiverOptionParser unit tests
load 'options/unit_tests_receiver_option_parser.rb'

# eof
