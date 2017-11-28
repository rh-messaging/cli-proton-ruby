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

# ConnectorOptionParser unit tests class
class UnitTestsConnectorOptionParser < Minitest::Test

  def test_connector_option_parser_default_broker_value
    connector_options_default_broker = Options::ConnectorOptionParser.new([])
    assert_equal(
      "127.0.0.1:5672",
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

  def test_connector_option_parser_default_count_value
    connector_options_default_count = Options::ConnectorOptionParser.new([])
    assert_equal(1, connector_options_default_count.options.count)
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
