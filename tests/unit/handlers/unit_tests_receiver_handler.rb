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
require_relative '../../../lib/handlers/receiver_handler'

# ReceiverHandler unit tests class
class UnitTestsReceiverHandler < Minitest::Test

  def setup
    @broker_value = "127.0.0.1:5672"
    @address_value = "examples"
    @log_msgs_value = "dict"
    @count_value = 1

    @receiver_handler_initialization = Handlers::ReceiverHandler.new(
      @broker_value,
      @address_value,
      @log_msgs_value,
      @count_value
    )
  end # setup

  def test_receiver_handler_broker_argument_initialization
    assert_equal(@broker_value, @receiver_handler_initialization.broker)
  end # test_receiver_handler_broker_argument_initialization

  def test_receiver_handler_address_argument_initialization
    assert_equal(@address_value, @receiver_handler_initialization.address)
  end # test_receiver_handler_address_argument_initialization

  def test_receiver_handler_log_msgs_argument_initialization
    assert_equal(@log_msgs_value, @receiver_handler_initialization.log_msgs)
  end # test_receiver_handler_log_msgs_argument_initialization

  def test_receiver_handler_count_argument_initialization
    assert_equal(@count_value, @receiver_handler_initialization.count)
  end # test_receiver_handler_count_argument_initialization

end # class UnitTestsReceiverHandler

# eof
