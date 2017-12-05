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

require_relative '../../../lib/options/receiver_option_parser'
require_relative '../../../lib/constants'

# ReceiverOptionParser unit tests class
class UnitTestsReceiverOptionParser < Minitest::Test

  def test_receiver_option_parser_default_broker_value
    receiver_options_default_broker = Options::ReceiverOptionParser.new([])
    assert_equal(
      Constants::DEFAULT_BROKER,
      receiver_options_default_broker.options.broker
    )
  end # test_receiver_option_parser_default_broker_value

  def test_receiver_option_parser_user_broker_value_short
    receiver_options_user_broker_short = Options::ReceiverOptionParser.new(
      ["-b", "127.0.0.2:5672"]
    )
    assert_equal(
      "127.0.0.2:5672",
      receiver_options_user_broker_short.options.broker
    )
  end # test_receiver_option_parser_user_broker_value_short

  def test_receiver_option_parser_user_broker_value_long
    receiver_options_user_broker_long = Options::ReceiverOptionParser.new(
      ["--broker", "127.0.0.3:5672"]
    )
    assert_equal(
      "127.0.0.3:5672",
      receiver_options_user_broker_long.options.broker
    )
  end # test_receiver_option_parser_user_broker_value_long

  def test_receiver_option_parser_default_address_value
    receiver_options_default_address = Options::ReceiverOptionParser.new([])
    assert_equal(
      Constants::DEFAULT_ADDRESS,
      receiver_options_default_address.options.address
    )
  end # test_receiver_option_parser_default_address_value

  def test_receiver_option_parser_user_address_value_short
    receiver_options_user_address_short = Options::ReceiverOptionParser.new(
      ["-a", "address_short"]
    )
    assert_equal(
      "address_short",
      receiver_options_user_address_short.options.address
    )
  end # test_receiver_option_parser_user_address_value_short

  def test_receiver_option_parser_user_address_value_long
    receiver_options_user_address_long = Options::ReceiverOptionParser.new(
      ["--address", "address_long"]
    )
    assert_equal(
      "address_long",
      receiver_options_user_address_long.options.address
    )
  end # test_receiver_option_parser_user_address_value_long

  def test_receiver_option_parser_default_log_msgs_value
    receiver_options_default_log_msgs = Options::ReceiverOptionParser.new([])
    assert_equal(
      Constants::DEFAULT_LOG_MSGS,
      receiver_options_default_log_msgs.options.log_msgs
    )
  end # test_receiver_option_parser_default_log_msgs_value

  def test_receiver_option_parser_user_log_msgs_value_long
    receiver_options_user_log_msgs_long = Options::ReceiverOptionParser.new(
      ["--log-msgs", "dict"]
    )
    assert_equal("dict", receiver_options_user_log_msgs_long.options.log_msgs)
  end # test_receiver_option_parser_user_log_msgs_value_long

  def test_receiver_option_parser_default_count_value
    receiver_options_default_count = Options::ReceiverOptionParser.new([])
    assert_equal(
      Constants::DEFAULT_COUNT,
      receiver_options_default_count.options.count
    )
  end # test_receiver_option_parser_default_count_value

  def test_receiver_option_parser_user_count_value_short
    receiver_options_user_count_short = Options::ReceiverOptionParser.new(
      ["-c", "2"]
    )
    assert_equal(2, receiver_options_user_count_short.options.count)
  end # test_receiver_option_parser_user_count_value_short

  def test_receiver_option_parser_user_count_value_long
    receiver_options_user_count_long = Options::ReceiverOptionParser.new(
      ["--count", "3"]
    )
    assert_equal(3, receiver_options_user_count_long.options.count)
  end # test_receiver_option_parser_user_count_value_long

end # class UnitTestsReceiverOptionParser

# eof
