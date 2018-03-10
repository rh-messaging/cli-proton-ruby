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
    @msg_content_value = "hello"
    @msg_durable_value = "True"
    @msg_ttl_value = 29
    @msg_correlation_id_value = "corr-id-0123456789"
    @msg_reply_to_value = "127.0.0.127:5672/reply_queue"
    @msg_group_id_value = "group-id-0987654321"
    @msg_priority = 42
    @sasl_mechs_value = "SASL"

    @sender_handler_initialization = Handlers::SenderHandler.new(
      @broker_value,
      @log_msgs_value,
      @count_value,
      @msg_content_value,
      @msg_durable_value,
      @msg_ttl_value,
      @msg_correlation_id_value,
      @msg_reply_to_value,
      @msg_group_id_value,
      @msg_priority,
      @sasl_mechs_value
    )
  end # setup

  def test_sender_handler_broker_argument_initialization_string
    sender_handler_initialization_string = Handlers::SenderHandler.new(
      @broker_value_string,
      @log_msgs_value,
      @count_value,
      @msg_content_value,
      @msg_durable_value,
      @msg_ttl_value,
      @msg_correlation_id_value,
      @msg_reply_to_value,
      @msg_group_id_value,
      @msg_priority,
      @sasl_mechs_value
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

  def test_sender_handler_msg_content_argument_initialization
    assert_equal(
      @msg_content_value,
      @sender_handler_initialization.msg_content
    )
  end # test_sender_handler_msg_content_argument_initialization

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

  def test_sender_handler_sasl_mechs_argument_initialization
    assert_equal(
      @sasl_mechs_value,
      @sender_handler_initialization.sasl_mechs
    )
  end # test_sender_handler_sasl_mechs_argument_initialization

end # class UnitTestsSenderHandler

# eof
