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

# Handlers unit tests
# BasicHandler unit tests
load 'unit/handlers/unit_tests_basic_handler.rb'
# ConnectorHandler unit tests
load 'unit/handlers/unit_tests_connector_handler.rb'
# SRCommonHandler unit tests
load 'unit/handlers/unit_tests_sr_common_handler.rb'
# SenderHandler unit tests
load 'unit/handlers/unit_tests_sender_handler.rb'
# ReceiverHandler unit tests
load 'unit/handlers/unit_tests_receiver_handler.rb'

# Options unit tests
# BasicOptionParser unit tests
load 'unit/options/unit_tests_basic_option_parser.rb'
# ConnectorOptionParser unit tests
load 'unit/options/unit_tests_connector_option_parser.rb'
# SRCommonOptionParser unit tests
load 'unit/options/unit_tests_sr_common_option_parser.rb'
# SenderOptionParser unit tests
load 'unit/options/unit_tests_sender_option_parser.rb'
# ReceiverOptionParser unit tests
load 'unit/options/unit_tests_receiver_option_parser.rb'

# Formatters unit tests
# BasicFormatter unit tests
load 'unit/formatters/unit_tests_basic_formatter.rb'
# DictFormatter unit tests
load 'unit/formatters/unit_tests_dict_formatter.rb'

# eof
