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

require_relative '../../../lib/options/connector_option_parser'
require_relative '../../../lib/defaults'

# ConnectorOptionParser unit tests class
class UnitTestsConnectorOptionParser < Minitest::Test

  def test_connector_option_parser_default_broker_value
    connector_options_default_broker = Options::ConnectorOptionParser.new([])
    assert_equal(
      Defaults::DEFAULT_BROKER,
      connector_options_default_broker.options.broker
    )
  end # test_connector_option_parser_default_broker_value

  def test_connector_option_parser_user_broker_value_short
    connector_options_user_broker_short = Options::ConnectorOptionParser.new(
      ["-b", "127.0.0.2:5672"]
    )
    assert_equal(
      "127.0.0.2:5672",
      connector_options_user_broker_short.options.broker
    )
  end # test_connector_option_parser_user_broker_value_short

  def test_connector_option_parser_user_broker_value_long
    connector_options_user_broker_long = Options::ConnectorOptionParser.new(
      ["--broker", "127.0.0.3:5672"]
    )
    assert_equal(
      "127.0.0.3:5672",
      connector_options_user_broker_long.options.broker
    )
  end # test_connector_option_parser_user_broker_value_long

  def test_connector_option_parser_default_exit_timer_value
    default_connector_options_exit_timer = Options::ConnectorOptionParser.new(
      []
    )
    assert_nil(
      default_connector_options_exit_timer.options.exit_timer
    )
  end # test_connector_option_parser_default_exit_timer_value

  def test_connector_option_parser_user_timeout_value_short_int
    user_connector_options_timeout_short_int = \
      Options::ConnectorOptionParser.new(["-t", "7"])
    assert_equal(
      7,
      user_connector_options_timeout_short_int.options.exit_timer.timeout
    )
  end # test_connector_option_parser_user_timeout_value_short_int

  def test_connector_option_parser_user_timeout_value_long_int
    user_connector_options_timeout_long_int = \
      Options::ConnectorOptionParser.new(["--timeout", "11"])
    assert_equal(
      11,
      user_connector_options_timeout_long_int.options.exit_timer.timeout
    )
  end # test_connector_option_parser_user_timeout_value_long_int

  def test_connector_option_parser_user_timeout_value_short_float
    user_connector_options_timeout_short_float = \
      Options::ConnectorOptionParser.new(["-t", "0.7"])
    assert_equal(
      0.7,
      user_connector_options_timeout_short_float.options.exit_timer.timeout
    )
  end # test_connector_option_parser_user_timeout_value_short_float

  def test_connector_option_parser_user_timeout_value_long_float
    user_connector_options_timeout_long_float = \
      Options::ConnectorOptionParser.new(["--timeout", "1.1"])
    assert_equal(
      1.1,
      user_connector_options_timeout_long_float.options.exit_timer.timeout
    )
  end # test_connector_option_parser_user_timeout_value_long_float

  def test_connector_option_parser_user_timeout_value_short_raise
    assert_raises OptionParser::InvalidArgument do
      Options::ConnectorOptionParser.new(["-t", "raise"])
    end
  end # test_connector_option_parser_user_timeout_value_short_raise

  def test_connector_option_parser_user_timeout_value_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::ConnectorOptionParser.new(["--timeout", "raise"])
    end
  end # test_connector_option_parser_user_timeout_value_long_raise

  def test_connector_option_parser_user_timeout_value_short_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::ConnectorOptionParser.new(["-t", wrong_value])
    end
    assert_equal(
      "invalid argument: -t #{wrong_value}",
      exception.message
    )
  end # test_connector_option_parser_user_timeout_value_short_raise_message

  def test_connector_option_parser_user_timeout_value_long_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::ConnectorOptionParser.new(["--timeout", wrong_value])
    end
    assert_equal(
      "invalid argument: --timeout #{wrong_value}",
      exception.message
    )
  end # test_connector_option_parser_user_timeout_value_long_raise_message

  def test_connector_option_parser_default_sasl_mechs_value
    default_connector_options_sasl_mechs = Options::ConnectorOptionParser.new(
      []
    )
    assert_equal(
      Defaults::DEFAULT_SASL_MECHS,
      default_connector_options_sasl_mechs.options.sasl_mechs
    )
  end # test_connector_option_parser_default_sasl_mechs_value

  def test_connector_option_parser_user_sasl_mechs_value_long
    user_connector_options_sasl_mechs_long = Options::ConnectorOptionParser.new(
      ["--conn-allowed-mechs", "SASL"]
    )
    assert_equal(
      "SASL",
      user_connector_options_sasl_mechs_long.options.sasl_mechs
    )
  end # test_connector_option_parser_user_sasl_mechs_value_long

  def test_connector_option_parser_default_count_value
    connector_options_default_count = Options::ConnectorOptionParser.new([])
    assert_equal(
      Defaults::DEFAULT_COUNT,
      connector_options_default_count.options.count
    )
  end # test_connector_option_parser_default_count_value

  def test_connector_option_parser_user_count_value_short
    connector_options_user_count_short = Options::ConnectorOptionParser.new(
      ["-c", "2"]
    )
    assert_equal(2, connector_options_user_count_short.options.count)
  end # test_connector_option_parser_user_count_value_short

  def test_connector_option_parser_user_count_value_long
    connector_options_user_count_long = Options::ConnectorOptionParser.new(
      ["--count", "3"]
    )
    assert_equal(3, connector_options_user_count_long.options.count)
  end # test_connector_option_parser_user_count_value_long

end # class UnitTestsConnectorOptionParser

# eof
