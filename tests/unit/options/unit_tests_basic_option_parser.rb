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

require_relative '../../../lib/options/basic_option_parser'
require_relative '../../../lib/defaults'

# BasicOptionParser unit tests class
class UnitTestsBasicOptionParser < Minitest::Test

  def test_basic_option_parser_default_broker_value
    default_basic_options_broker = Options::BasicOptionParser.new()
    default_basic_options_broker.parse([])
    assert_equal(
      Defaults::DEFAULT_BROKER,
      default_basic_options_broker.options.broker
    )
  end # test_basic_option_parser_default_broker_value

  def test_basic_option_parser_user_broker_value_short
    user_basic_options_broker_short = Options::BasicOptionParser.new()
    user_basic_options_broker_short.parse(["-b", "127.0.0.2:5672"])
    assert_equal(
      "127.0.0.2:5672",
      user_basic_options_broker_short.options.broker
    )
  end # test_basic_option_parser_user_broker_value_short

  def test_basic_option_parser_user_broker_value_long
    user_basic_options_broker_long = Options::BasicOptionParser.new()
    user_basic_options_broker_long.parse(["--broker", "127.0.0.3:5672"])
    assert_equal(
      "127.0.0.3:5672",
      user_basic_options_broker_long.options.broker
    )
  end # test_basic_option_parser_user_broker_value_long

  def test_basic_option_parser_default_sasl_mechs_value
    default_basic_options_sasl_mechs = Options::BasicOptionParser.new()
    default_basic_options_sasl_mechs.parse([])
    assert_equal(
      Defaults::DEFAULT_SASL_MECHS,
      default_basic_options_sasl_mechs.options.sasl_mechs
    )
  end # test_basic_option_parser_default_sasl_mechs_value

  def test_basic_option_parser_user_sasl_mechs_value_long
    user_basic_options_sasl_mechs_long = Options::BasicOptionParser.new()
    user_basic_options_sasl_mechs_long.parse(
      ["--conn-allowed-mechs", "SASL"]
    )
    assert_equal(
      "SASL",
      user_basic_options_sasl_mechs_long.options.sasl_mechs
    )
  end # test_basic_option_parser_user_sasl_mechs_value_long

end # class UnitTestsBasicOptionParser

# eof
