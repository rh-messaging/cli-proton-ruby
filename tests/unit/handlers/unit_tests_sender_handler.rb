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
require_relative '../../../lib/handlers/sender_handler'

# SenderHandler unit tests class
class UnitTestsSenderHandler < Minitest::Test

  def setup
    @broker_value_string = "127.0.0.4:5672"
    @broker_value = Qpid::Proton.uri(@broker_value_string)
    @log_msgs_value = "dict"
    @count_value = 7
    @msg_properties_value = {"property-key" => "property-value"}
    @msg_content_value = "hello"
    @msg_content_type_value = "msg-content-type-value"
    @msg_durable_value = "True"
    @msg_ttl_value = 29
    @msg_correlation_id_value = "corr-id-0123456789"
    @msg_reply_to_value = "127.0.0.127:5672/reply_queue"
    @msg_group_id_value = "group-id-0987654321"
    @msg_priority_value = 42
    @msg_id_value = "message-id-112657"
    @msg_user_id_value = "user-id-666"
    @msg_subject_value = "subject-swordfish"
    @anonymous_value = true
    @sasl_mechs_value = "SASL"
    @idle_timeout_value = 85
    @max_frame_size_value = 7757
    @log_lib_value = "TRANSPORT_FRM"
    @auto_settle_off_value = "settle"
    @exit_timer_value = "timeout"

    @sender_handler_initialization = Handlers::SenderHandler.new(
      @broker_value,
      @log_msgs_value,
      @count_value,
      @msg_properties_value,
      @msg_content_value,
      @msg_content_type_value,
      @msg_durable_value,
      @msg_ttl_value,
      @msg_correlation_id_value,
      @msg_reply_to_value,
      @msg_group_id_value,
      @msg_priority_value,
      @msg_id_value,
      @msg_user_id_value,
      @msg_subject_value,
      @anonymous_value,
      @sasl_mechs_value,
      @idle_timeout_value,
      @max_frame_size_value,
      @log_lib_value,
      @auto_settle_off_value,
      @exit_timer_value,
    )
  end # setup

  def test_sender_handler_broker_argument_initialization_string
    sender_handler_initialization_string = Handlers::SenderHandler.new(
      @broker_value_string,
      @log_msgs_value,
      @count_value,
      @msg_properties_value,
      @msg_content_value,
      @msg_content_type_value,
      @msg_durable_value,
      @msg_ttl_value,
      @msg_correlation_id_value,
      @msg_reply_to_value,
      @msg_group_id_value,
      @msg_priority_value,
      @msg_id_value,
      @msg_user_id_value,
      @msg_subject_value,
      @anonymous_value,
      @sasl_mechs_value,
      @idle_timeout_value,
      @max_frame_size_value,
      @log_lib_value,
      @auto_settle_off_value,
      @exit_timer_value
    )

    assert_equal(
      @broker_value.to_s,
      sender_handler_initialization_string.broker.to_s
    )
  end # test_sender_handler_broker_argument_initialization_string

  def test_sender_handler_broker_argument_initialization_class
    assert_equal(
      @broker_value.to_s,
      @sender_handler_initialization.broker.to_s
    )
  end # test_sender_handler_broker_argument_initialization_class

  def test_sender_handler_log_msgs_argument_initialization
    assert_equal(@log_msgs_value, @sender_handler_initialization.log_msgs)
  end # test_sender_handler_log_msgs_argument_initialization

  def test_sender_handler_count_argument_initialization
    assert_equal(@count_value, @sender_handler_initialization.count)
  end # test_sender_handler_count_argument_initialization

  def test_sender_handler_msg_properties_argument_initialization
    assert_equal(
      @msg_properties_value,
      @sender_handler_initialization.msg_properties
    )
  end # test_sender_handler_msg_properties_argument_initialization

  def test_sender_handler_msg_content_argument_initialization
    assert_equal(
      @msg_content_value,
      @sender_handler_initialization.msg_content
    )
  end # test_sender_handler_msg_content_argument_initialization

  def test_sender_handler_msg_content_type_argument_initialization
    assert_equal(
      @msg_content_type_value,
      @sender_handler_initialization.msg_content_type
    )
  end # test_sender_handler_msg_content_type_argument_initialization

  def test_sender_handler_msg_durable_argument_initialization
    assert_equal(
      @msg_durable_value,
      @sender_handler_initialization.msg_durable
    )
  end # test_sender_handler_msg_durable_argument_initialization

  def test_sender_handler_msg_ttl_argument_initialization
    assert_equal(
      @msg_ttl_value,
      @sender_handler_initialization.msg_ttl
    )
  end # test_sender_handler_msg_durable_argument_initialization

  def test_sender_handler_msg_correlation_id_argument_initialization
    assert_equal(
      @msg_correlation_id_value,
      @sender_handler_initialization.msg_correlation_id
    )
  end # test_sender_handler_msg_correlation_id_argument_initialization

  def test_sender_handler_msg_reply_to_argument_initialization
    assert_equal(
      @msg_reply_to_value,
      @sender_handler_initialization.msg_reply_to
    )
  end # test_sender_handler_msg_correlation_id_argument_initialization

  def test_sender_handler_msg_group_id_argument_initialization
    assert_equal(
      @msg_group_id_value,
      @sender_handler_initialization.msg_group_id
    )
  end # test_sender_handler_msg_group_id_argument_initialization

  def test_sender_handler_msg_priority_argument_initialization
    assert_equal(
      @msg_priority_value,
      @sender_handler_initialization.msg_priority
    )
  end # test_sender_handler_msg_priority_argument_initialization

  def test_sender_handler_msg_id_argument_initialization
    assert_equal(
      @msg_id_value,
      @sender_handler_initialization.msg_id
    )
  end # test_sender_handler_msg_id_argument_initialization

  def test_sender_handler_msg_user_id_argument_initialization
    assert_equal(
      @msg_user_id_value,
      @sender_handler_initialization.msg_user_id
    )
  end # test_sender_handler_msg_user_id_argument_initialization

  def test_sender_handler_msg_subject_argument_initialization
    assert_equal(
      @msg_subject_value,
      @sender_handler_initialization.msg_subject
    )
  end # test_sender_handler_msg_subject_argument_initialization

  def test_sender_handler_anonymous_argument_initialization
    assert_equal(
      @anonymous_value,
      @sender_handler_initialization.anonymous
    )
  end # test_sender_handler_anonymous_argument_initialization

  def test_sender_handler_sasl_mechs_argument_initialization
    assert_equal(
      @sasl_mechs_value,
      @sender_handler_initialization.sasl_mechs
    )
  end # test_sender_handler_sasl_mechs_argument_initialization

  def test_sender_handler_idle_timeout_argument_initialization
    assert_equal(
        @idle_timeout_value,
        @sender_handler_initialization.idle_timeout
    )
  end # test_sender_handler_idle_timeout_argument_initialization

  def test_sender_handler_max_frame_size_argument_initialization
    assert_equal(
        @max_frame_size_value,
        @sender_handler_initialization.max_frame_size
    )
  end # test_sender_handler_max_frame_size_argument_initialization

  def test_sender_handler_log_lib_argument_initialization
    assert_equal(
        @log_lib_value,
        @sender_handler_initialization.log_lib
    )
  end # test_sender_handler_log_lib_argument_initialization

  def test_sender_handler_auto_settle_off_argument_initialization
    assert_equal(
        @auto_settle_off_value,
        @sender_handler_initialization.auto_settle_off
    )
  end # test_sender_handler_auto_settle_off_argument_initialization

  def test_sender_handler_exit_timer_argument_initialization
    assert_equal(
      @exit_timer_value,
      @sender_handler_initialization.exit_timer
    )
  end # test_sender_handler_exit_timer_argument_initialization

end # class UnitTestsSenderHandler

# eof
