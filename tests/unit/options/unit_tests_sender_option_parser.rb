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

  def test_sender_option_parser_default_exit_timer_value
    default_sender_options_exit_timer = Options::SenderOptionParser.new(
      []
    )
    assert_nil(
      default_sender_options_exit_timer.options.exit_timer
    )
  end # test_sender_option_parser_default_exit_timer_value

  def test_sender_option_parser_user_timeout_value_short_int
    user_sender_options_timeout_short_int = Options::SenderOptionParser.new(
      ["-t", "7"]
    )
    assert_equal(
      7,
      user_sender_options_timeout_short_int.options.exit_timer.timeout
    )
  end # test_sender_option_parser_user_timeout_value_short_int

  def test_sender_option_parser_user_timeout_value_long_int
    user_sender_options_timeout_long_int = Options::SenderOptionParser.new(
      ["--timeout", "11"]
    )
    assert_equal(
      11,
      user_sender_options_timeout_long_int.options.exit_timer.timeout
    )
  end # test_sender_option_parser_user_timeout_value_long_int

  def test_sender_option_parser_user_timeout_value_short_float
    user_sender_options_timeout_short_float = \
      Options::SenderOptionParser.new(["-t", "0.7"])
    assert_equal(
      0.7,
      user_sender_options_timeout_short_float.options.exit_timer.timeout
    )
  end # test_sender_option_parser_user_timeout_value_short_float

  def test_sender_option_parser_user_timeout_value_long_float
    user_sender_options_timeout_long_float = \
      Options::SenderOptionParser.new(["--timeout", "1.1"])
    assert_equal(
      1.1,
      user_sender_options_timeout_long_float.options.exit_timer.timeout
    )
  end # test_sender_option_parser_user_timeout_value_long_float

  def test_sender_option_parser_user_timeout_value_short_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(["-t", "raise"])
    end
  end # test_sender_option_parser_user_timeout_value_short_raise

  def test_sender_option_parser_user_timeout_value_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(["--timeout", "raise"])
    end
  end # test_sender_option_parser_user_timeout_value_long_raise

  def test_sender_option_parser_user_timeout_value_short_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(["-t", wrong_value])
    end
    assert_equal(
      "invalid argument: -t #{wrong_value}",
      exception.message
    )
  end # test_sender_option_parser_user_timeout_value_short_raise_message

  def test_sender_option_parser_user_timeout_value_long_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(["--timeout", wrong_value])
    end
    assert_equal(
      "invalid argument: --timeout #{wrong_value}",
      exception.message
    )
  end # test_sender_option_parser_user_timeout_value_long_raise_message

  def test_sender_option_parser_default_sasl_mechs_value
    default_sender_options_sasl_mechs = Options::SenderOptionParser.new([])
    assert_equal(
      Defaults::DEFAULT_SASL_MECHS,
      default_sender_options_sasl_mechs.options.sasl_mechs
    )
  end # test_sender_option_parser_default_sasl_mechs_value

  def test_sender_option_parser_user_sasl_mechs_value_long
    user_sender_options_sasl_mechs_long = Options::SenderOptionParser.new(
      ["--conn-allowed-mechs", "SASL"]
    )
    assert_equal(
      "SASL",
      user_sender_options_sasl_mechs_long.options.sasl_mechs
    )
  end # test_sender_option_parser_user_sasl_mechs_value_long

  def test_sender_option_parser_default_idle_timeout_value
    default_sender_options_idle_timeout = Options::SenderOptionParser.new(
      []
    )
    assert_equal(
      Defaults::DEFAULT_IDLE_TIMEOUT,
      default_sender_options_idle_timeout.options.idle_timeout
    )
  end # test_sender_option_parser_default_idle_timeout_value

  def test_sender_option_parser_user_idle_timeout_value_long
    user_sender_options_idle_timeout_long = \
      Options::SenderOptionParser.new(["--conn-heartbeat", "13"])
    assert_equal(
      13,
      user_sender_options_idle_timeout_long.options.idle_timeout
    )
  end # test_sender_option_parser_user_idle_timeout_value_long

  def test_sender_option_parser_user_idle_timeout_value_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(["--conn-heartbeat", "raise"])
    end
  end # test_sender_option_parser_user_idle_timeout_value_long_raise

  def test_sender_option_parser_user_idle_timeout_value_long_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(["--conn-heartbeat", wrong_value])
    end
    assert_equal(
      "invalid argument: --conn-heartbeat #{wrong_value}",
      exception.message
    )
  end # test_sender_option_parser_user_idle_timeout_value_long_raise_message

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

  def test_sender_option_parser_default_msg_property_value
    sender_options_default_msg_property = Options::SenderOptionParser.new(
      []
    )
    assert_nil(Defaults::DEFAULT_MSG_PROPERTIES)
    assert_nil(sender_options_default_msg_property.options.msg_properties)
  end # test_sender_option_parser_default_msg_property_value

  def test_sender_option_parser_user_msg_property_value_short_string
    sender_options_user_msg_property_short_string = \
      Options::SenderOptionParser.new(["-P", "key_short=value_short"])
    assert_equal(
      {"key_short" => "value_short"},
      sender_options_user_msg_property_short_string.options.msg_properties
    )
    sender_options_user_msg_property_short_string.options.msg_properties.clear
  end # test_sender_option_parser_user_msg_property_value_short_string

  def test_sender_option_parser_user_msg_property_value_long_string
    sender_options_user_msg_property_long_string = \
      Options::SenderOptionParser.new(["--msg-property", "key_long=value_long"])
    assert_equal(
      {"key_long" => "value_long"},
      sender_options_user_msg_property_long_string.options.msg_properties
    )
    sender_options_user_msg_property_long_string.options.msg_properties.clear
  end # test_sender_option_parser_user_msg_property_value_long_string

  def test_sender_option_parser_user_msg_property_value_short_int
    sender_options_user_msg_property_short_int = \
      Options::SenderOptionParser.new(["-P", "key_short~42"])
    assert_equal(
      {"key_short" => 42},
      sender_options_user_msg_property_short_int.options.msg_properties
    )
    sender_options_user_msg_property_short_int.options.msg_properties.clear
  end # test_sender_option_parser_user_msg_property_value_short_int

  def test_sender_option_parser_user_msg_property_value_long_int
    sender_options_user_msg_property_long_int = \
      Options::SenderOptionParser.new(["--msg-property", "key_long~42"])
    assert_equal(
      {"key_long" => 42},
      sender_options_user_msg_property_long_int.options.msg_properties
    )
    sender_options_user_msg_property_long_int.options.msg_properties.clear
  end # test_sender_option_parser_user_msg_property_value_long_int

  def test_sender_option_parser_user_msg_property_value_short_float
    sender_options_user_msg_property_short_float = \
      Options::SenderOptionParser.new(["-P", "key_short~4.2"])
    assert_equal(
      {"key_short" => 4.2},
      sender_options_user_msg_property_short_float.options.msg_properties
    )
    sender_options_user_msg_property_short_float.options.msg_properties.clear
  end # test_sender_option_parser_user_msg_property_value_short_float

  def test_sender_option_parser_user_msg_property_value_long_float
    sender_options_user_msg_property_long_float = \
      Options::SenderOptionParser.new(["--msg-property", "key_long~4.2"])
    assert_equal(
      {"key_long" => 4.2},
      sender_options_user_msg_property_long_float.options.msg_properties
    )
    sender_options_user_msg_property_long_float.options.msg_properties.clear
  end # test_sender_option_parser_user_msg_property_value_long_float

  def test_sender_option_parser_user_msg_property_value_short_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(["-P", "key_short"])
    end
  end # test_sender_option_parser_user_msg_property_value_short_raise

  def test_sender_option_parser_user_msg_property_value_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(["--msg-property", "key_long"])
    end
  end # test_sender_option_parser_user_msg_property_value_long_raise

  def test_sender_option_parser_user_msg_property_value_short_raise_message
    wrong_value = "key_short"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(["-P", wrong_value])
    end
    assert_equal(
      "invalid argument: -P kv pair '#{wrong_value}' is of invalid format, "\
      "= or ~ required",
      exception.message
    )
  end # test_sender_option_parser_user_msg_property_value_short_raise_message

  def test_sender_option_parser_user_msg_property_value_long_raise_message
    wrong_value = "key_long"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(["--msg-property", wrong_value])
    end
    assert_equal(
      "invalid argument: --msg-property kv pair '#{wrong_value}' is of "\
      "invalid format, = or ~ required",
      exception.message
    )
  end # test_sender_option_parser_user_msg_property_value_long_raise_message

  def test_sender_option_parser_user_content_type_msg_property_values
    for type, param, expect in [%w(string 1 1), ["int", "1", 1], ["long", "1", 1],
                                ["float", "1", 1.0], ["bool", "true", true]]
      sender_options_user_msg_content_map_item_long = \
        Options::SenderOptionParser.new([
          "--msg-property", "key=#{param}", "--content-type", type
        ])
      assert_equal(
          {"key" => expect},
          sender_options_user_msg_content_map_item_long.options.msg_properties
      )
    end
  end # test_sender_option_parser_user_content_type_msg_property_values


  def test_sender_option_parser_default_msg_content_value
    sender_options_default_msg_content = Options::SenderOptionParser.new([])
    assert_nil(
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

  def test_sender_option_parser_user_msg_content_from_file_long
    filename = "tests/unit/options/msg_content_from_file.txt"
    sender_options_user_msg_content_from_file_long = \
      Options::SenderOptionParser.new([
        "--msg-content-from-file", filename
      ])
    assert_equal(
      File.read(filename),
      sender_options_user_msg_content_from_file_long.options.msg_content
    )
  end # test_sender_option_parser_user_msg_content_from_file_long

  def test_sender_option_parser_user_content_type_msg_content_from_file_values
    for type, param, expect in [%w(string 1 1), ["int", "1", 1], ["long", "1", 1],
                                ["float", "1", 1.0], ["bool", "true", true]]
      file = Tempfile.new("test_sender_option_parser_user_content_type_msg_content_from_file_values")
      begin
        file.write(param)
        file.flush
        sender_options_user_msg_content_map_item_long = \
          Options::SenderOptionParser.new([
            "--msg-content-from-file", file.path, "--content-type", type
        ])
        assert_equal(
          expect,
          sender_options_user_msg_content_map_item_long.options.msg_content
        )
      ensure
        file.close
        file.unlink
      end
    end
  end # test_sender_option_parser_user_content_type_msg_content_from_file_values

  def test_sender_option_parser_user_content_type_msg_content_values
    for type, param, expect in [%w(string 1 1), ["int", "1", 1], ["long", "1", 1],
                               ["float", "1.1", 1.1], ["bool", "true", true]]
      assert_equal(
          expect,
          Options::SenderOptionParser.new(
              ["--content-type", type, "--msg-content", param]).options.msg_content
      )
    end
  end # test_sender_option_parser_user_content_type_msg_content_list_item_values

  def test_sender_option_parser_default_msg_content_type_value
    sender_options_default_msg_content_type = Options::SenderOptionParser.new(
      []
    )
    assert_nil(
      sender_options_default_msg_content_type.options.msg_content_type
    )
  end # test_sender_option_parser_default_msg_content_type_value

  def test_sender_option_parser_user_msg_content_type_value_long
    sender_options_user_msg_content_type_long = Options::SenderOptionParser.new(
      ["--msg-content-type", "type"]
    )
    assert_equal(
      "type",
      sender_options_user_msg_content_type_long.options.msg_content_type
    )
  end # test_sender_option_parser_user_msg_content_type_value_long

  def test_sender_option_parser_default_msg_priority_value
    sender_options_default_msg_priority = Options::SenderOptionParser.new([])
    assert_nil(
      sender_options_default_msg_priority.options.msg_priority
    )
  end # test_sender_option_parser_default_msg_priority_value

  def test_sender_option_parser_user_msg_priority_value_long
    sender_options_user_msg_priority_long = Options::SenderOptionParser.new(
      ["--msg-priority", "10"]
    )
    assert_equal(
      10,
      sender_options_user_msg_priority_long.options.msg_priority
    )
  end # test_sender_option_parser_user_msg_priority_value_long

  def test_sender_option_parser_user_msg_priority_value_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(["--msg-priority", "1a0"])
    end
  end # test_sender_option_parser_user_msg_priority_value_long_raise

  def test_sender_option_parser_user_msg_priority_value_long_raise_message
    wrong_value = "1a0"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(["--msg-priority", wrong_value])
    end
    assert_equal(
      "invalid argument: --msg-priority #{wrong_value}",
      exception.message
    )
  end # test_sender_option_parser_user_msg_priority_value_long_raise_message

  def test_sender_option_parser_default_msg_id_value
    sender_options_default_msg_id = Options::SenderOptionParser.new([])
    assert_nil(
      sender_options_default_msg_id.options.msg_id
    )
  end # test_sender_option_parser_default_msg_id_value

  def test_sender_option_parser_user_msg_id_value_long
    value = "msg-id-1357"
    sender_options_user_msg_id_long = Options::SenderOptionParser.new(
      ["--msg-id", value]
    )
    assert_equal(
      value,
      sender_options_user_msg_id_long.options.msg_id
    )
  end # test_sender_option_parser_user_msg_id_value_long

  def test_sender_option_parser_default_msg_user_id_value
    sender_options_default_msg_user_id = Options::SenderOptionParser.new([])
    assert_nil(
      sender_options_default_msg_user_id.options.msg_user_id
    )
  end # test_sender_option_parser_default_msg_user_id_value

  def test_sender_option_parser_user_msg_user_id_value_long
    value = "msg-user-id-02468"
    sender_options_user_msg_user_id_long = Options::SenderOptionParser.new(
      ["--msg-user-id", value]
    )
    assert_equal(
      value,
      sender_options_user_msg_user_id_long.options.msg_user_id
    )
  end # test_sender_option_parser_user_msg_user_id_value_long

  def test_sender_option_parser_default_msg_subject_value
    sender_options_default_msg_subject = Options::SenderOptionParser.new([])
    assert_nil(
      sender_options_default_msg_subject.options.msg_subject
    )
  end # test_sender_option_parser_default_msg_subject_value

  def test_sender_option_parser_user_msg_subject_value_long
    value = "msg-subject-0112358"
    sender_options_user_msg_subject_long = Options::SenderOptionParser.new(
      ["--msg-subject", value]
    )
    assert_equal(
      value,
      sender_options_user_msg_subject_long.options.msg_subject
    )
  end # test_sender_option_parser_user_msg_subject_value_long

  def test_sender_option_parser_default_anonymous_value
    sender_options_default_anonymous = Options::SenderOptionParser.new([])
    assert_equal(
        Defaults::DEFAULT_ANONYMOUS,
        sender_options_default_anonymous.options.anonymous
    )
  end # test_sender_option_parser_default_anonymous_value

  def test_sender_option_parser_user_anonymous_no_value
    sender_options_user_anonymous_no_value = Options::SenderOptionParser.new(
        ["--anonymous"]
    )
    assert_equal(
        true,
        sender_options_user_anonymous_no_value.options.anonymous
    )
  end # test_sender_option_parser_user_anonymous_no_value

  def test_sender_option_parser_user_anonymous_true_value_long
    sender_options_user_anonymous_long = Options::SenderOptionParser.new(
        ["--anonymous", "true"]
    )
    assert_equal(
        true,
        sender_options_user_anonymous_long.options.anonymous
    )
  end # test_sender_option_parser_user_anonymous_true_value_long

  def test_sender_option_parser_user_anonymous_false_value_long
    sender_options_user_anonymous_long = Options::SenderOptionParser.new(
        ["--anonymous", "false"]
    )
    assert_equal(
        false,
        sender_options_user_anonymous_long.options.anonymous
    )
  end # test_sender_option_parser_user_anonymous_false_value_long

  def test_sender_option_parser_user_anonymous_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(["--anonymous", wrong_value])
    end
    assert_equal(
        "invalid argument: --anonymous #{wrong_value}",
        exception.message
    )
  end # test_sender_option_parser_user_anonymous_raise_message


  def test_sender_option_parser_default_msg_corr_id_value
    sender_options_default_msg_corr_id = Options::SenderOptionParser.new([])
    assert_nil(
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

  def test_sender_option_parser_default_msg_reply_to_value
    sender_options_default_msg_reply_to = Options::SenderOptionParser.new([])
    assert_nil(
      sender_options_default_msg_reply_to.options.msg_reply_to
    )
  end # test_sender_option_parser_default_msg_reply_to_value

  def test_sender_option_parser_user_msg_reply_to_value_long
    sender_options_user_msg_reply_to = Options::SenderOptionParser.new(
      ["--msg-reply-to", "127.0.0.1:5672/reply"]
    )
    assert_equal(
      "127.0.0.1:5672/reply",
      sender_options_user_msg_reply_to.options.msg_reply_to
    )
  end # test_sender_option_parser_user_msg_reply_to_value_long

  def test_sender_option_parser_default_msg_group_id_value
    sender_options_default_msg_group_id = Options::SenderOptionParser.new([])
    assert_nil(
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
    sender_options_user_msg_content_map_item_short = \
      Options::SenderOptionParser.new([
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
    sender_options_user_msg_content_map_item_long = \
      Options::SenderOptionParser.new([
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

  def test_sender_option_parser_user_content_type_msg_content_map_item_values
    for type, param, expect in [%w(string 1 1), ["int", "1", 1], ["long", "1", 1],
                                ["float", "1", 1.0], ["bool", "true", true]]
      sender_options_user_msg_content_map_item_long = \
        Options::SenderOptionParser.new([
          "--msg-content-map-item", "key=#{param}", "--content-type", type
        ])
      assert_equal(
        { "key" => expect },
        sender_options_user_msg_content_map_item_long.options.msg_content
      )
    end
  end # test_sender_option_parser_user_content_type_msg_content_map_item_values


  def test_sender_option_parser_user_msg_content_list_item_value_short
    sender_options_user_msg_content_list_item_short = \
      Options::SenderOptionParser.new([
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
    sender_options_user_msg_content_list_item_long = \
      Options::SenderOptionParser.new([
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

  def test_sender_option_parser_user_content_type_msg_content_list_item_values
    for type, param, expect in [%w(string 1 1), ["int", "1", 1], ["long", "1", 1],
                                ["float", "1", 1.0], ["bool", "true", true]]
      assert_equal(
          [expect],
          Options::SenderOptionParser.new(
              ["-L", param, "--content-type", type]).options.msg_content
      )
    end
  end # test_sender_option_parser_user_content_type_msg_content_list_item_values


  def test_sender_option_parser_user_content_type_msg_content_list_item_invalid_value_raise_message
    for type, param in [%w(int 1.1), %w(long 1.1), %w(float raise), %w(bool raise)]
      exception = assert_raises ArgumentError do
        Options::SenderOptionParser.new(["--content-type", type, "-L", param])
      end
      assert_match(
          /invalid value for .* "#{param}"/,
          exception.message
      )
    end
  end # test_sender_option_parser_user_content_type_msg_content_list_item_invalid_value_raise_message

  def test_sender_option_parser_user_content_type_msg_content_map_item_invalid_value_raise_message
    for type, param in [%w(int 1.1), %w(long 1.1), %w(float raise), %w(bool raise)]
      exception = assert_raises ArgumentError do
        Options::SenderOptionParser.new(["--content-type", type, "-M", "key=#{param}"])
      end
      assert_match(
          /invalid value for .* "#{param}"/,
          exception.message
      )
    end
  end # test_sender_option_parser_user_content_type_msg_content_map_item_invalid_value_raise_message

  def test_sender_option_parser_user_content_type_msg_property_invalid_value_raise_message
    for type, param in [%w(int 1.1), %w(long 1.1), %w(float raise), %w(bool raise)]
      exception = assert_raises ArgumentError do
        Options::SenderOptionParser.new(["--content-type", type, "--msg-property", "key=#{param}"])
      end
      assert_match(
          /invalid value for .* "#{param}"/,
          exception.message
      )
    end
  end # test_sender_option_parser_user_content_type_msg_property_invalid_value_raise_message

  def test_sender_option_parser_user_content_type_msg_content_from_file_invalid_value_raise_message
    for type, param in [%w(int 1.1), %w(long 1.1), %w(float raise), %w(bool raise)]
      file = Tempfile.new('test_sender_option_parser_user_content_type_msg_content_from_file_invalid_value_raise_message')
      begin
        file.write(param)
        file.flush
        exception = assert_raises ArgumentError do
          Options::SenderOptionParser.new(["--content-type", type, "--msg-content-from-file", file.path])
        end
        assert_match(
            /invalid value for .* "#{param}"/,
            exception.message
        )
      ensure
        file.close
        file.unlink   # deletes the temp file
      end
    end
  end # test_sender_option_parser_user_content_type_msg_content_from_file_invalid_value_raise_message

  def test_sender_option_parser_default_content_type_values
    sender_options_default_content_type = Options::SenderOptionParser.new([])
    assert_equal(
      Defaults::DEFAULT_CONTENT_TYPE,
      sender_options_default_content_type.options.content_type
    )
  end # test_sender_option_parser_default_content_type_value

  def test_sender_option_parser_user_content_type_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(["--content-type", wrong_value])
    end
    assert_equal(
        "invalid argument: --content-type #{wrong_value}",
        exception.message
    )
  end # test_sender_option_parser_user_content_type_raise_message


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

  def test_sender_option_parser_default_max_frame_size_value
    default_sender_options_max_frame_size = Options::SenderOptionParser.new([])
    assert_equal(
      Defaults::DEFAULT_MAX_FRAME_SIZE,
      default_sender_options_max_frame_size.options.max_frame_size
    )
  end # test_sender_option_parser_default_max_frame_size_value

  def test_sender_option_parser_user_max_frame_size_value_long
    user_sender_options_max_frame_size_long = Options::SenderOptionParser.new(
      ["--conn-max-frame-size", "3331"]
    )
    assert_equal(
      3331,
      user_sender_options_max_frame_size_long.options.max_frame_size
    )
  end # test_sender_option_parser_user_max_frame_size_value_long

  def test_sender_option_parser_user_max_frame_size_value_long_range_lower_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(
        ["--conn-max-frame-size", "#{Defaults::DEFAULT_MIN_MAX_FRAME_SIZE-1}"]
      )
    end
  end # test_sender_option_parser_user_max_frame_size_value_long_range_lower_raise

  def test_sender_option_parser_user_max_frame_size_value_long_range_lower_raise_msg
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(
        ["--conn-max-frame-size", "#{Defaults::DEFAULT_MIN_MAX_FRAME_SIZE-1}"]
      )
    end
    assert_equal(
      "invalid argument: --conn-max-frame-size " +
      "#{Defaults::DEFAULT_MIN_MAX_FRAME_SIZE-1} (out of range: " +
      "#{Defaults::DEFAULT_MIN_MAX_FRAME_SIZE}-" +
      "#{Defaults::DEFAULT_MAX_MAX_FRAME_SIZE})",
      exception.message
    )
  end # test_sender_option_parser_user_max_frame_size_value_long_range_lower_raise_msg

  def test_sender_option_parser_user_max_frame_size_value_long_range_upper_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(
        ["--conn-max-frame-size", "#{Defaults::DEFAULT_MAX_MAX_FRAME_SIZE+1}"]
      )
    end
  end # test_sender_option_parser_user_max_frame_size_value_long_range_upper_raise

  def test_sender_option_parser_user_max_frame_size_value_long_range_upper_raise_msg
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(
        ["--conn-max-frame-size", "#{Defaults::DEFAULT_MAX_MAX_FRAME_SIZE+1}"]
      )
    end
    assert_equal(
      "invalid argument: --conn-max-frame-size " +
      "#{Defaults::DEFAULT_MAX_MAX_FRAME_SIZE+1} (out of range: " +
      "#{Defaults::DEFAULT_MIN_MAX_FRAME_SIZE}-" +
      "#{Defaults::DEFAULT_MAX_MAX_FRAME_SIZE})",
      exception.message
    )
  end # test_sender_option_parser_user_max_frame_size_value_long_range_upper_raise_msg

  def test_sender_option_parser_user_max_frame_size_value_long_wrong_value_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(
        ["--conn-max-frame-size", "wrong_value"]
      )
    end
  end # test_sender_option_parser_user_max_frame_size_value_long_wrong_value_raise

  def test_sender_option_parser_user_max_frame_size_value_long_wrong_value_raise_msg
    wrong_value = "wrong_value"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(
        ["--conn-max-frame-size", "#{wrong_value}"]
      )
    end
    assert_equal(
      "invalid argument: --conn-max-frame-size #{wrong_value}",
      exception.message
    )
  end # test_sender_option_parser_user_max_frame_size_value_long_wrong_value_raise_msg

  def test_sender_option_parser_default_log_lib_value
    default_sender_options_log_lib = Options::SenderOptionParser.new([])
    assert_equal(
      Defaults::DEFAULT_LOG_LIB,
      default_sender_options_log_lib.options.log_lib
    )
  end # test_sender_option_parser_default_log_lib_value

  def test_sender_option_parser_user_log_lib_value_long
    value = "TRANSPORT_FRM"
    user_sender_options_log_lib_long = Options::SenderOptionParser.new(
      ["--log-lib", value]
    )
    assert_equal(
      value,
      user_sender_options_log_lib_long.options.log_lib
    )
  end # test_sender_option_parser_user_log_lib_value_long

  def test_sender_option_parser_user_log_lib_value_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(
        ["--log-lib", "raise"]
      )
    end
  end # test_sender_option_parser_user_log_lib_value_long_raise

  def test_sender_option_parser_user_log_lib_value_long_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(
        ["--log-lib", wrong_value]
      )
    end
    assert_equal(
      "invalid argument: --log-lib #{wrong_value}",
      exception.message
    )
  end # test_sender_option_parser_user_log_lib_value_long_raise_message

  def test_sender_option_parser_default_auto_settle_off_value
    default_sender_options_auto_settle_off = Options::SenderOptionParser.new([])
    assert_equal(
      Defaults::DEFAULT_AUTO_SETTLE_OFF,
      default_sender_options_auto_settle_off.options.auto_settle_off
    )
  end # test_sender_option_parser_default_auto_settle_off_value

  def test_sender_option_parser_user_auto_settle_off_value_long_no_value
    user_sender_options_auto_settle_off_long_no_value = Options::SenderOptionParser.new(
      ["--auto-settle-off"]
    )
    assert_equal(
      true,
      user_sender_options_auto_settle_off_long_no_value.options.auto_settle_off
    )
  end # test_sender_option_parser_user_auto_settle_off_value_long_no_value

  def test_sender_option_parser_user_auto_settle_off_value_long
    Options::BOOLEAN_STRINGS.each do |auto_settle_off_value_long|
      user_sender_options_auto_settle_off_long = Options::SenderOptionParser.new(
        ["--auto-settle-off", auto_settle_off_value_long]
      )
      assert_equal(
        StringUtils.str_to_bool(auto_settle_off_value_long),
        user_sender_options_auto_settle_off_long.options.auto_settle_off
      )
    end
  end # test_sender_option_parser_user_auto_settle_off_value_long

  def test_sender_option_parser_user_auto_settle_off_value_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(
        ["--auto-settle-off", "raise"]
      )
    end
  end # test_sender_option_parser_user_auto_settle_off_value_long_raise

  def test_sender_option_parser_user_auto_settle_off_value_long_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SenderOptionParser.new(
        ["--auto-settle-off", wrong_value]
      )
    end
    assert_equal(
      "invalid argument: --auto-settle-off #{wrong_value}",
      exception.message
    )
  end # test_sender_option_parser_user_auto_settle_off_value_long_raise_message

end # class UnitTestsSenderOptionParser

# eof
