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
require_relative '../../../lib/defaults'

# SRCommonOptionParser unit tests class
class UnitTestsSRCommonOptionParser < Minitest::Test

  def parse(args)
    p = Options::SRCommonOptionParser.new()
    p.parse(args)
    p
  end

  def test_sr_common_option_parser_default_broker_value
    sr_common_options_default_broker = Options::SRCommonOptionParser.new()
    sr_common_options_default_broker.parse([])
    assert_equal(
      Defaults::DEFAULT_BROKER,
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

  def test_sr_common_option_parser_default_exit_timer_value
    default_sr_common_options_exit_timer = Options::SRCommonOptionParser.new()
    default_sr_common_options_exit_timer.parse([])
    assert_nil(
      default_sr_common_options_exit_timer.options.exit_timer
    )
  end # test_sr_common_option_parser_default_exit_timer_value

  def test_sr_common_option_parser_user_timeout_value_short_int
    user_sr_common_options_timeout_short_int = \
      Options::SRCommonOptionParser.new()
    user_sr_common_options_timeout_short_int.parse(["-t", "7"])
    assert_equal(
      7,
      user_sr_common_options_timeout_short_int.options.exit_timer.timeout
    )
  end # test_sr_common_option_parser_user_timeout_value_short_int

  def test_sr_common_option_parser_user_timeout_value_long_int
    user_sr_common_options_timeout_long_int = \
      Options::SRCommonOptionParser.new()
    user_sr_common_options_timeout_long_int.parse(["--timeout", "11"])
    assert_equal(
      11,
      user_sr_common_options_timeout_long_int.options.exit_timer.timeout
    )
  end # test_sr_common_option_parser_user_timeout_value_long_int

  def test_sr_common_option_parser_user_timeout_value_short_float
    user_sr_common_options_timeout_short_float = \
      Options::SRCommonOptionParser.new()
    user_sr_common_options_timeout_short_float.parse(["-t", "0.7"])
    assert_equal(
      0.7,
      user_sr_common_options_timeout_short_float.options.exit_timer.timeout
    )
  end # test_sr_common_option_parser_user_timeout_value_short_float

  def test_sr_common_option_parser_user_timeout_value_long_float
    user_sr_common_options_timeout_long_float = \
      Options::SRCommonOptionParser.new()
    user_sr_common_options_timeout_long_float.parse(["--timeout", "1.1"])
    assert_equal(
      1.1,
      user_sr_common_options_timeout_long_float.options.exit_timer.timeout
    )
  end # test_sr_common_option_parser_user_timeout_value_long_float

  def test_sr_common_option_parser_user_timeout_value_short_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(["-t", "raise"])
    end
  end # test_sr_common_option_parser_user_timeout_value_short_raise

  def test_sr_common_option_parser_user_timeout_value_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(["--timeout", "raise"])
    end
  end # test_sr_common_option_parser_user_timeout_value_long_raise

  def test_sr_common_option_parser_user_timeout_value_short_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(["-t", wrong_value])
    end
    assert_equal(
      "invalid argument: -t #{wrong_value}",
      exception.message
    )
  end # test_sr_common_option_parser_user_timeout_value_short_raise_message

  def test_sr_common_option_parser_user_timeout_value_long_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(["--timeout", wrong_value])
    end
    assert_equal(
      "invalid argument: --timeout #{wrong_value}",
      exception.message
    )
  end # test_sr_common_option_parser_user_timeout_value_long_raise_message

  def test_sr_common_option_parser_default_sasl_mechs_value
    default_sr_common_options_sasl_mechs = Options::SRCommonOptionParser.new()
    default_sr_common_options_sasl_mechs.parse([])
    assert_equal(
      Defaults::DEFAULT_SASL_MECHS,
      default_sr_common_options_sasl_mechs.options.sasl_mechs
    )
  end # test_sr_common_option_parser_default_sasl_mechs_value

  def test_sr_common_option_parser_user_sasl_mechs_value_long
    user_sr_common_options_sasl_mechs_long = Options::SRCommonOptionParser.new()
    user_sr_common_options_sasl_mechs_long.parse(
      ["--conn-allowed-mechs", "SASL"]
    )
    assert_equal(
      "SASL",
      user_sr_common_options_sasl_mechs_long.options.sasl_mechs
    )
  end # test_sr_common_option_parser_user_sasl_mechs_value_long

  def test_sr_common_option_parser_default_idle_timeout_value
    default_sr_common_options_idle_timeout = Options::SRCommonOptionParser.new()
    default_sr_common_options_idle_timeout.parse([])
    assert_equal(
      Defaults::DEFAULT_IDLE_TIMEOUT,
      default_sr_common_options_idle_timeout.options.idle_timeout
    )
  end # test_sr_common_option_parser_default_idle_timeout_value

  def test_sr_common_option_parser_user_idle_timeout_value_long
    user_sr_common_options_idle_timeout_long = \
      Options::SRCommonOptionParser.new()
    user_sr_common_options_idle_timeout_long.parse(
      ["--conn-heartbeat", "13"]
    )
    assert_equal(
      13,
      user_sr_common_options_idle_timeout_long.options.idle_timeout
    )
  end # test_sr_common_option_parser_user_idle_timeout_value_long

  def test_sr_common_option_parser_user_idle_timeout_value_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(["--conn-heartbeat", "raise"])
    end
  end # test_sr_common_option_parser_user_idle_timeout_value_long_raise

  def test_sr_common_option_parser_user_idle_timeout_value_long_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(
        ["--conn-heartbeat", wrong_value]
      )
    end
    assert_equal(
      "invalid argument: --conn-heartbeat #{wrong_value}",
      exception.message
    )
  end # test_sr_common_option_parser_user_idle_timeout_value_long_raise_message

  def test_sr_common_option_parser_default_log_msgs_value
    sr_common_options_default_log_msgs = Options::SRCommonOptionParser.new()
    sr_common_options_default_log_msgs.parse([])
    assert_equal(
      Defaults::DEFAULT_LOG_MSGS,
      sr_common_options_default_log_msgs.options.log_msgs
    )
  end # test_sr_common_option_parser_default_log_msgs_value

  def test_sr_common_option_parser_user_log_msgs_value_long
    sr_common_options_user_log_msgs_long = Options::SRCommonOptionParser.new()
    sr_common_options_user_log_msgs_long.parse(["--log-msgs", "dict"])
    assert_equal(
      "dict",
      sr_common_options_user_log_msgs_long.options.log_msgs
    )
  end # test_sr_common_option_parser_user_log_msgs_value_long

  def test_sr_common_option_parser_user_log_msgs_value_long_interop
    sr_common_options_user_log_msgs_long_interop = \
      Options::SRCommonOptionParser.new()
    sr_common_options_user_log_msgs_long_interop.parse(["--log-msgs", "interop"])
    assert_equal(
      "interop",
      sr_common_options_user_log_msgs_long_interop.options.log_msgs
    )
  end # test_sr_common_option_parser_user_log_msgs_value_long

  def test_sr_common_option_parser_user_log_msgs_value_wrong_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(["--log-msgs", "hello"])
    end
  end # test_sr_common_option_parser_user_log_msgs_value_wrong_long_raise

  def test_sr_common_option_parser_user_log_msgs_value_wrong_long_raise_msg
    wrong_value = "hello"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(["--log-msgs", wrong_value])
    end
    assert_equal(
      "invalid argument: --log-msgs #{wrong_value}",
      exception.message
    )
  end # test_sr_common_option_parser_user_log_msgs_value_wrong_long_raise_msg

  def test_sr_common_option_parser_default_msg_content_hashed_value
    default_sr_common_options_msg_content_hashed = Options::SRCommonOptionParser.new()
    default_sr_common_options_msg_content_hashed.parse([])
    assert_equal(
      Defaults::DEFAULT_MSG_CONTENT_HASHED,
      default_sr_common_options_msg_content_hashed.options.msg_content_hashed
    )
  end # test_sr_common_option_parser_default_msg_content_hashed_value

  def test_sr_common_option_parser_user_msg_content_hashed_value_long_no_value
    user_sr_common_options_msg_content_hashed_long_no_value = Options::SRCommonOptionParser.new()
    user_sr_common_options_msg_content_hashed_long_no_value.parse(
      ["--msg-content-hashed"]
    )
    assert_equal(
      true,
      user_sr_common_options_msg_content_hashed_long_no_value.options.msg_content_hashed
    )
  end # test_sr_common_option_parser_user_msg_content_hashed_value_long_no_value

  def test_sr_common_option_parser_user_msg_content_hashed_value_long
    Options::BOOLEAN_STRINGS.each do |msg_content_hashed_value_long|
      user_sr_common_options_msg_content_hashed_long = Options::SRCommonOptionParser.new()
      user_sr_common_options_msg_content_hashed_long.parse(
        ["--msg-content-hashed", msg_content_hashed_value_long]
      )
      assert_equal(
        StringUtils.str_to_bool(msg_content_hashed_value_long),
        user_sr_common_options_msg_content_hashed_long.options.msg_content_hashed
      )
    end
  end # test_sr_common_option_parser_user_msg_content_hashed_value_long

  def test_sr_common_option_parser_user_msg_content_hashed_value_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(
        ["--msg-content-hashed", "raise"]
      )
    end
  end # test_sr_common_option_parser_user_msg_content_hashed_value_long_raise

  def test_sr_common_option_parser_user_msg_content_hashed_value_long_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(
        ["--msg-content-hashed", wrong_value]
      )
    end
    assert_equal(
      "invalid argument: --msg-content-hashed #{wrong_value}",
      exception.message
    )
  end # test_sr_common_option_parser_user_msg_content_hashed_value_long_raise_message

  def test_sr_common_option_parser_default_max_frame_size_value
    default_sr_common_options_max_frame_size = Options::SRCommonOptionParser.new()
    default_sr_common_options_max_frame_size.parse([])
    assert_equal(
      Defaults::DEFAULT_MAX_FRAME_SIZE,
      default_sr_common_options_max_frame_size.options.max_frame_size
    )
  end # test_sr_common_option_parser_default_max_frame_size_value

  def test_sr_common_option_parser_user_max_frame_size_value_long
    user_sr_common_options_max_frame_size_long = Options::SRCommonOptionParser.new()
    user_sr_common_options_max_frame_size_long.parse(
      ["--conn-max-frame-size", "3331"]
    )
    assert_equal(
      3331,
      user_sr_common_options_max_frame_size_long.options.max_frame_size
    )
  end # test_sr_common_option_parser_user_max_frame_size_value_long

  def test_sr_common_option_parser_user_max_frame_size_value_long_range_lower_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(
        ["--conn-max-frame-size", "#{Defaults::DEFAULT_MIN_MAX_FRAME_SIZE-1}"]
      )
    end
  end # test_sr_common_option_parser_user_max_frame_size_value_long_range_lower_raise

  def test_sr_common_option_parser_user_max_frame_size_value_long_range_lower_raise_msg
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(
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
  end # test_sr_common_option_parser_user_max_frame_size_value_long_range_lower_raise_msg

  def test_sr_common_option_parser_user_max_frame_size_value_long_range_upper_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(
        ["--conn-max-frame-size", "#{Defaults::DEFAULT_MAX_MAX_FRAME_SIZE+1}"]
      )
    end
  end # test_sr_common_option_parser_user_max_frame_size_value_long_range_upper_raise

  def test_sr_common_option_parser_user_max_frame_size_value_long_range_upper_raise_msg
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(
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
  end # test_sr_common_option_parser_user_max_frame_size_value_long_range_upper_raise_msg

  def test_sr_common_option_parser_user_max_frame_size_value_long_wrong_value_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(
        ["--conn-max-frame-size", "wrong_value"]
      )
    end
  end # test_sr_common_option_parser_user_max_frame_size_value_long_wrong_value_raise

  def test_sr_common_option_parser_user_max_frame_size_value_long_wrong_value_raise_msg
    wrong_value = "wrong_value"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(
        ["--conn-max-frame-size", "#{wrong_value}"]
      )
    end
    assert_equal(
      "invalid argument: --conn-max-frame-size #{wrong_value}",
      exception.message
    )
  end # test_sr_common_option_parser_user_max_frame_size_value_long_wrong_value_raise_msg

  def test_sr_common_option_parser_default_sasl_enabled_value
    default_sr_common_options_sasl_enabled = Options::SRCommonOptionParser.new()
    default_sr_common_options_sasl_enabled.parse([])
    assert_equal(
      Defaults::DEFAULT_SASL_ENABLED,
      default_sr_common_options_sasl_enabled.options.sasl_enabled
    )
  end # test_sr_common_option_parser_default_sasl_enabled_value

  def test_sr_common_option_parser_user_sasl_enabled_no_value
    sr_common_options_user_sasl_enabled_no_value = Options::SRCommonOptionParser.new()
    sr_common_options_user_sasl_enabled_no_value.parse(
        ["--conn-sasl-enabled"]
    )
    assert_equal(
        true,
        sr_common_options_user_sasl_enabled_no_value.options.sasl_enabled
    )
  end # test_sr_common_option_parser_user_sasl_enabled_no_value

  def test_sr_common_option_parser_user_sasl_enabled_value_long
    Options::BOOLEAN_STRINGS.each do |boolean_value|
      user_sr_common_options_sasl_enabled_long = Options::SRCommonOptionParser.new()
      user_sr_common_options_sasl_enabled_long.parse(
        ["--conn-sasl-enabled", "#{boolean_value}"]
      )
      assert_equal(
        StringUtils.str_to_bool(boolean_value),
        user_sr_common_options_sasl_enabled_long.options.sasl_enabled
      )
    end
  end # test_sr_common_option_parser_user_sasl_enabled_value_long

  def test_sr_common_option_parser_user_sasl_enabled_value_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(
        ["--conn-sasl-enabled", "raise"]
      )
    end
  end # test_sr_common_option_parser_user_sasl_enabled_value_long_raise

  def test_sr_common_option_parser_user_sasl_enabled_value_long_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(
        ["--conn-sasl-enabled", wrong_value]
      )
    end
    assert_equal(
      "invalid argument: --conn-sasl-enabled #{wrong_value}",
      exception.message
    )
  end # test_sr_common_option_parser_user_sasl_enabled_value_long_raise_message

  def test_sr_common_option_parser_default_log_lib_value
    default_sr_common_options_log_lib = Options::SRCommonOptionParser.new()
    default_sr_common_options_log_lib.parse([])
    assert_equal(
      Defaults::DEFAULT_LOG_LIB,
      default_sr_common_options_log_lib.options.log_lib
    )
  end # test_sr_common_option_parser_default_log_lib_value

  def test_sr_common_option_parser_user_log_lib_value_long
    value = "TRANSPORT_FRM"
    user_sr_common_options_log_lib_long = Options::SRCommonOptionParser.new()
    user_sr_common_options_log_lib_long.parse(
      ["--log-lib", value]
    )
    assert_equal(
      value,
      user_sr_common_options_log_lib_long.options.log_lib
    )
  end # test_sr_common_option_parser_user_log_lib_value_long

  def test_sr_common_option_parser_user_log_lib_value_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(
        ["--log-lib", "raise"]
      )
    end
  end # test_sr_common_option_parser_user_log_lib_value_long_raise

  def test_sr_common_option_parser_user_log_lib_value_long_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(
        ["--log-lib", wrong_value]
      )
    end
    assert_equal(
      "invalid argument: --log-lib #{wrong_value}",
      exception.message
    )
  end # test_sr_common_option_parser_user_log_lib_value_long_raise_message

  def test_sr_common_option_parser_default_auto_settle_off_value
    default_sr_common_options_auto_settle_off = Options::SRCommonOptionParser.new()
    default_sr_common_options_auto_settle_off.parse([])
    assert_equal(
      Defaults::DEFAULT_AUTO_SETTLE_OFF,
      default_sr_common_options_auto_settle_off.options.auto_settle_off
    )
  end # test_sr_common_option_parser_default_auto_settle_off_value

  def test_sr_common_option_parser_user_auto_settle_off_value_long_no_value
    user_sr_common_options_auto_settle_off_long_no_value = Options::SRCommonOptionParser.new()
    user_sr_common_options_auto_settle_off_long_no_value.parse(
      ["--auto-settle-off"]
    )
    assert_equal(
      true,
      user_sr_common_options_auto_settle_off_long_no_value.options.auto_settle_off
    )
  end # test_sr_common_option_parser_user_auto_settle_off_value_long_no_value

  def test_sr_common_option_parser_user_auto_settle_off_value_long
    Options::BOOLEAN_STRINGS.each do |auto_settle_off_value_long|
      user_sr_common_options_auto_settle_off_long = Options::SRCommonOptionParser.new()
      user_sr_common_options_auto_settle_off_long.parse(
        ["--auto-settle-off", auto_settle_off_value_long]
      )
      assert_equal(
        StringUtils.str_to_bool(auto_settle_off_value_long),
        user_sr_common_options_auto_settle_off_long.options.auto_settle_off
      )
    end
  end # test_sr_common_option_parser_user_auto_settle_off_value_long

  def test_sr_common_option_parser_user_auto_settle_off_value_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(
        ["--auto-settle-off", "raise"]
      )
    end
  end # test_sr_common_option_parser_user_auto_settle_off_value_long_raise

  def test_sr_common_option_parser_user_auto_settle_off_value_long_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(
        ["--auto-settle-off", wrong_value]
      )
    end
    assert_equal(
      "invalid argument: --auto-settle-off #{wrong_value}",
      exception.message
    )
  end # test_sr_common_option_parser_user_auto_settle_off_value_long_raise_message

  def test_sr_common_option_parser_duration
    assert_equal 0, parse([]).options.duration
    assert_equal 12.34, parse(["--duration", "12.34"]).options.duration
    assert_raises(OptionParser::InvalidArgument) { parse(["--duration", "xxx"]) }
  end
end # class UnitTestsSRCommonOptionParser

# eof
