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
require_relative '../../../lib/defaults'

# ReceiverOptionParser unit tests class
class UnitTestsReceiverOptionParser < Minitest::Test

  def test_receiver_option_parser_default_broker_value
    receiver_options_default_broker = Options::ReceiverOptionParser.new([])
    assert_equal(
      Defaults::DEFAULT_BROKER,
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

  def test_receiver_option_parser_default_sasl_mechs_value
    default_receiver_options_sasl_mechs = Options::BasicOptionParser.new()
    default_receiver_options_sasl_mechs.parse([])
    assert_equal(
      Defaults::DEFAULT_SASL_MECHS,
      default_receiver_options_sasl_mechs.options.sasl_mechs
    )
  end # test_receiver_option_parser_default_sasl_mechs_value

  def test_receiver_option_parser_user_sasl_mechs_value_long
    user_receiver_options_sasl_mechs_long = Options::BasicOptionParser.new()
    user_receiver_options_sasl_mechs_long.parse(
      ["--conn-allowed-mechs", "SASL"]
    )
    assert_equal(
      "SASL",
      user_receiver_options_sasl_mechs_long.options.sasl_mechs
    )
  end # test_receiver_option_parser_user_sasl_mechs_value_long

  def test_receiver_option_parser_default_log_msgs_value
    receiver_options_default_log_msgs = Options::ReceiverOptionParser.new([])
    assert_equal(
      Defaults::DEFAULT_LOG_MSGS,
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
      Defaults::DEFAULT_COUNT,
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

  def test_receiver_option_parser_default_recv_browse_value
    receiver_options_default_recv_browse = Options::ReceiverOptionParser.new([])
    assert_equal(
      Defaults::DEFAULT_BROWSE,
      receiver_options_default_recv_browse.options.browse
    )
  end # test_receiver_option_parser_default_recv_browse_value

  def test_receiver_option_parser_user_recv_browse_value_long
    receiver_options_user_recv_browse_long = Options::ReceiverOptionParser.new(
      ["--recv-browse"]
    )
    assert_equal(true, receiver_options_user_recv_browse_long.options.browse)
  end # test_receiver_option_parser_user_recv_browse_value_long

end # class UnitTestsReceiverOptionParser

# eof
