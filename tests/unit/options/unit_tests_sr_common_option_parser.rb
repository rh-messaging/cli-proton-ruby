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

require_relative '../../../lib/options/sr_common_option_parser'

# SRCommonOptionParser unit tests class
class UnitTestsSRCommonOptionParser < Minitest::Test

  def test_sr_common_option_parser_default_broker_value
    sr_common_options_default_broker = Options::SRCommonOptionParser.new()
    sr_common_options_default_broker.parse([])
    assert_equal(
      "127.0.0.1:5672",
      sr_common_options_default_broker.options.broker
    )
  end # test_sr_common_option_parser_default_broker_value

  def test_sr_common_option_parser_user_broker_value_short
    sr_common_options_user_broker_short = Options::SRCommonOptionParser.new()
    sr_common_options_user_broker_short.parse(["-b", "127.0.0.2:5672"])
    assert_equal(
      "127.0.0.2:5672",
      sr_common_options_user_broker_short.options.broker
    )
  end # test_sr_common_option_parser_user_broker_value_short

  def test_sr_common_option_parser_user_broker_value_long
    sr_common_options_user_broker_long = Options::SRCommonOptionParser.new()
    sr_common_options_user_broker_long.parse(["--broker", "127.0.0.3:5672"])
    assert_equal(
      "127.0.0.3:5672",
      sr_common_options_user_broker_long.options.broker
    )
  end # test_sr_common_option_parser_user_broker_value_long

  def test_sr_common_option_parser_default_address_value
    sr_common_options_default_address = Options::SRCommonOptionParser.new()
    sr_common_options_default_address.parse([])
    assert_equal(
      "examples",
      sr_common_options_default_address.options.address
    )
  end # test_sr_common_option_parser_default_address_value

  def test_sr_common_option_parser_user_address_value_short
    sr_common_options_user_address_short = Options::SRCommonOptionParser.new()
    sr_common_options_user_address_short.parse(["-a", "address_short"])
    assert_equal(
      "address_short",
      sr_common_options_user_address_short.options.address
    )
  end # test_sr_common_option_parser_user_address_value_short

  def test_sr_common_option_parser_user_address_value_long
    sr_common_options_user_address_long = Options::SRCommonOptionParser.new()
    sr_common_options_user_address_long.parse(["--address", "address_long"])
    assert_equal(
      "address_long",
      sr_common_options_user_address_long.options.address
    )
  end # test_sr_common_option_parser_user_address_value_long

  def test_sr_common_option_parser_default_log_msgs_value
    sr_common_options_default_log_msgs = Options::SRCommonOptionParser.new()
    sr_common_options_default_log_msgs.parse([])
    assert_equal("none", sr_common_options_default_log_msgs.options.log_msgs)
  end # test_sr_common_option_parser_default_log_msgs_value

  def test_sr_common_option_parser_user_log_msgs_value_long
    sr_common_options_user_log_msgs_long = Options::SRCommonOptionParser.new()
    sr_common_options_user_log_msgs_long.parse(["--log-msgs", "dict"])
    assert_equal(
      "dict",
      sr_common_options_user_log_msgs_long.options.log_msgs
    )
  end # test_sr_common_option_parser_user_log_msgs_value_long

end # class UnitTestsSRCommonOptionParser

# eof
