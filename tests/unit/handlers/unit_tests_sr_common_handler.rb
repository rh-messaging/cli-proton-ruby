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
require_relative '../../../lib/handlers/sr_common_handler'

# SRCommonHandler unit tests class
class UnitTestsSRCommonHandler < Minitest::Test

  def setup
    @broker_value_string = "127.0.0.1:5672"
    @broker_value = Qpid::Proton.uri(@broker_value_string)
    @address_value = "examples"
    @log_msgs_value = "dict"

    @sr_common_handler_initialization = Handlers::SRCommonHandler.new(
      @broker_value,
      @address_value,
      @log_msgs_value
    )
  end # setup

  def test_sr_common_handler_broker_argument_initialization_string
    sr_common_handler_initialization_string = Handlers::SRCommonHandler.new(
      @broker_value_string,
      @address_value,
      @log_msgs_value
    )

    assert_equal(
      @broker_value.to_s,
      sr_common_handler_initialization_string.broker.to_s
    )
  end # test_sr_common_handler_broker_argument_initialization_string

  def test_sr_common_handler_broker_argument_initialization_class
    assert_equal(
      @broker_value.to_s,
      @sr_common_handler_initialization.broker.to_s
    )
  end # test_sr_common_handler_broker_argument_initialization_class

  def test_sr_common_handler_address_argument_initialization
    assert_equal(@address_value, @sr_common_handler_initialization.address)
  end # test_sr_common_handler_address_argument_initialization

  def test_sr_common_handler_log_msgs_argument_initialization
    assert_equal(@log_msgs_value, @sr_common_handler_initialization.log_msgs)
  end # test_sr_common_handler_log_msgs_argument_initialization

end # class UnitTestsSRCommonHandler

# eof
