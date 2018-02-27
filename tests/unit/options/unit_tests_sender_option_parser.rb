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

require_relative '../../../lib/options/sender_option_parser'
require_relative '../../../lib/defaults'

# SenderOptionParser unit tests class
class UnitTestsSenderOptionParser < Minitest::Test

  def test_sender_option_parser_default_broker_value
    sender_options_default_broker = Options::SenderOptionParser.new([])
    assert_equal(
      Defaults::DEFAULT_BROKER,
      sender_options_default_broker.options.broker
    )
  end # test_sender_option_parser_default_broker_value

  def test_sender_option_parser_user_broker_value_short
    sender_options_user_broker_short = Options::SenderOptionParser.new(
      ["-b", "127.0.0.2:5672"]
    )
    assert_equal(
      "127.0.0.2:5672",
      sender_options_user_broker_short.options.broker
    )
  end # test_sender_option_parser_user_broker_value_short

  def test_sender_option_parser_user_broker_value_long
    sender_options_user_broker_long = Options::SenderOptionParser.new(
      ["--broker", "127.0.0.3:5672"]
    )
    assert_equal(
      "127.0.0.3:5672",
      sender_options_user_broker_long.options.broker
    )
  end # test_sender_option_parser_user_broker_value_long

  def test_sender_option_parser_default_sasl_mechs_value
    default_sender_options_sasl_mechs = Options::BasicOptionParser.new()
    default_sender_options_sasl_mechs.parse([])
    assert_equal(
      Defaults::DEFAULT_SASL_MECHS,
      default_sender_options_sasl_mechs.options.sasl_mechs
    )
  end # test_sender_option_parser_default_sasl_mechs_value

  def test_sender_option_parser_user_sasl_mechs_value_long
    user_sender_options_sasl_mechs_long = Options::BasicOptionParser.new()
    user_sender_options_sasl_mechs_long.parse(
      ["--conn-allowed-mechs", "SASL"]
    )
    assert_equal(
      "SASL",
      user_sender_options_sasl_mechs_long.options.sasl_mechs
    )
  end # test_sender_option_parser_user_sasl_mechs_value_long

  def test_sender_option_parser_default_log_msgs_value
    sender_options_default_log_msgs = Options::SenderOptionParser.new([])
    assert_equal(
      Defaults::DEFAULT_LOG_MSGS,
      sender_options_default_log_msgs.options.log_msgs
    )
  end # test_sender_option_parser_default_log_msgs_value

  def test_sender_option_parser_user_log_msgs_value_long
    sender_options_user_log_msgs_long = Options::SenderOptionParser.new(
      ["--log-msgs", "dict"]
    )
    assert_equal("dict", sender_options_user_log_msgs_long.options.log_msgs)
  end # test_sender_option_parser_user_log_msgs_value_long

  def test_sender_option_parser_default_count_value
    sender_options_default_count = Options::SenderOptionParser.new([])
    assert_equal(
      Defaults::DEFAULT_COUNT,
      sender_options_default_count.options.count
    )
  end # test_sender_option_parser_default_count_value

  def test_sender_option_parser_user_count_value_short
    sender_options_user_count_short = Options::SenderOptionParser.new(
      ["-c", "2"]
    )
    assert_equal(2, sender_options_user_count_short.options.count)
  end # test_sender_option_parser_user_count_value_short

  def test_sender_option_parser_user_count_value_long
    sender_options_user_count_long = Options::SenderOptionParser.new(
      ["--count", "3"]
    )
    assert_equal(3, sender_options_user_count_long.options.count)
  end # test_sender_option_parser_user_count_value_long

  def test_sender_option_parser_default_msg_content_value
    sender_options_default_msg_content = Options::SenderOptionParser.new([])
    assert_nil(
      Defaults::DEFAULT_MSG_CONTENT,
      sender_options_default_msg_content.options.msg_content
    )
  end # test_sender_option_parser_default_msg_content_value

  def test_sender_option_parser_user_msg_content_value_long
    sender_options_user_msg_content_long = Options::SenderOptionParser.new(
      ["--msg-content", "hello"]
    )
    assert_equal(
      "hello",
      sender_options_user_msg_content_long.options.msg_content
    )
  end # test_sender_option_parser_user_msg_content_value_long

  def test_sender_option_parser_default_msg_corr_id_value
    sender_options_default_msg_corr_id = Options::SenderOptionParser.new([])
    assert_nil(
      Defaults::DEFAULT_CORR_ID,
      sender_options_default_msg_corr_id.options.msg_correlation_id
    )
  end # test_sender_option_parser_default_msg_corr_id_value

  def test_sender_option_parser_user_msg_corr_id_value_long
    sender_options_user_msg_corr_id = Options::SenderOptionParser.new(
      ["--msg-correlation-id", "corr-id-0123456789"]
    )
    assert_equal(
      "corr-id-0123456789",
      sender_options_user_msg_corr_id.options.msg_correlation_id
    )
  end # test_sender_option_parser_user_msg_corr_id_value_long

  def test_sender_option_parser_default_msg_group_id_value
    sender_options_default_msg_group_id = Options::SenderOptionParser.new([])
    assert_nil(
      Defaults::DEFAULT_GROUP_ID,
      sender_options_default_msg_group_id.options.msg_group_id
    )
  end # test_sender_option_parser_default_msg_group_id_value

  def test_sender_option_parser_user_msg_group_id_value_long
    sender_options_user_msg_group_id_long = Options::SenderOptionParser.new(
      ["--msg-group-id", "group-id-0987654321"]
    )
    assert_equal(
      "group-id-0987654321",
      sender_options_user_msg_group_id_long.options.msg_group_id
    )
  end # test_sender_option_parser_user_msg_group_id_value_long

  def test_sender_option_parser_user_msg_content_map_item_value_short
    sender_options_user_msg_content_map_item_short = Options::SenderOptionParser.new([
      "-M", "string=String",
      "-M", "int~1",
      "-M", "float~1.0",
      "-M", "empty_string=",
      "-M", "negative_float~-1.3",
      "-M", "string_int=1",
      "-M", "string_negative_int=-1",
      "-M", "negative_int~-1",
      "-M", "string_float=1.0",
      "-M", "string_retype_operator=~1"
    ])
    assert_equal(
      {
        "string" => 'String',
        "int" => 1,
        "float" => 1.0,
        "empty_string" => '',
        "negative_float" => -1.3,
        "string_int" => '1',
        "string_negative_int" => '-1',
        "negative_int" => -1,
        "string_float" => '1.0',
        "string_retype_operator" => '~1'
      },
      sender_options_user_msg_content_map_item_short.options.msg_content
    )
  end # test_sender_option_parser_user_msg_content_map_item_value_short

  def test_sender_option_parser_user_msg_content_map_item_value_long
    sender_options_user_msg_content_map_item_long = Options::SenderOptionParser.new([
      "--msg-content-map-item", "string=String",
      "--msg-content-map-item", "int~1",
      "--msg-content-map-item", "float~1.0",
      "--msg-content-map-item", "empty_string=",
      "--msg-content-map-item", "negative_float~-1.3",
      "--msg-content-map-item", "string_int=1",
      "--msg-content-map-item", "string_negative_int=-1",
      "--msg-content-map-item", "negative_int~-1",
      "--msg-content-map-item", "string_float=1.0",
      "--msg-content-map-item", "string_retype_operator=~1"
    ])
    assert_equal(
      {
        "string" => 'String',
        "int" => 1,
        "float" => 1.0,
        "empty_string" => '',
        "negative_float" => -1.3,
        "string_int" => '1',
        "string_negative_int" => '-1',
        "negative_int" => -1,
        "string_float" => '1.0',
        "string_retype_operator" => '~1'
      },
      sender_options_user_msg_content_map_item_long.options.msg_content
    )
  end # test_sender_option_parser_user_msg_content_map_item_value_long


  def test_sender_option_parser_user_msg_content_list_item_value_short
    sender_options_user_msg_content_list_item_short = Options::SenderOptionParser.new([
      "-L", "",
      "-L", "String",
      "-L", "~1",
      "-L", "~1.0",
      "-L", "1",
      "-L", "1.0",
      "-L", "~-1",
      "-L", "~-1.3",
      "-L", "-1",
      "-L", "~~1"
    ])
    assert_equal(
      ['', 'String', 1, 1.0, '1', '1.0', -1, -1.3, '-1', '~1'],
      sender_options_user_msg_content_list_item_short.options.msg_content
    )
  end # test_sender_option_parser_user_msg_content_list_item_value_short

  def test_sender_option_parser_user_msg_content_list_item_value_long
    sender_options_user_msg_content_list_item_long = Options::SenderOptionParser.new([
      "--msg-content-list-item", "",
      "--msg-content-list-item", "String",
      "--msg-content-list-item", "~1",
      "--msg-content-list-item", "~1.0",
      "--msg-content-list-item", "1",
      "--msg-content-list-item", "1.0",
      "--msg-content-list-item", "~-1",
      "--msg-content-list-item", "~-1.3",
      "--msg-content-list-item", "-1",
      "--msg-content-list-item", "~~1"
    ])
    assert_equal(
      ['', 'String', 1, 1.0, '1', '1.0', -1, -1.3, '-1', '~1'],
      sender_options_user_msg_content_list_item_long.options.msg_content
    )
  end # test_sender_option_parser_user_msg_content_list_item_value_long

  def test_sender_option_parser_default_msg_durable_value
    sender_options_default_msg_durable = Options::SenderOptionParser.new([])
    assert_equal(
      Defaults::DEFAULT_MSG_DURABLE,
      sender_options_default_msg_durable.options.msg_durable
    )
  end # test_sender_option_parser_default_msg_durable_value

  def test_sender_option_parser_user_msg_durable_value_long
    value = Defaults::DEFAULT_MSG_DURABLE ? false : true
    sender_options_user_msg_durable_long = Options::SenderOptionParser.new([
      "--msg-durable", "#{value}"
    ])
    assert_equal(
      value,
      sender_options_user_msg_durable_long.options.msg_durable
    )
  end # test_sender_option_parser_user_msg_durable_value_long

  def test_sender_option_parser_default_msg_ttl_value
    sender_options_default_msg_ttl = Options::SenderOptionParser.new([])
    assert_equal(
      Defaults::DEFAULT_MSG_TTL,
      sender_options_default_msg_ttl.options.msg_ttl
    )
  end # test_sender_option_parser_default_msg_ttl_value

  def test_sender_option_parser_user_msg_ttl_value_long
    value = Defaults::DEFAULT_MSG_TTL + 23
    sender_options_user_msg_ttl_long = Options::SenderOptionParser.new([
      "--msg-ttl", "#{value}"
    ])
    assert_equal(
      value,
      sender_options_user_msg_ttl_long.options.msg_ttl
    )
  end # test_sender_option_parser_user_msg_ttl_value_long

end # class UnitTestsSenderOptionParser

# eof
