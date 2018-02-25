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
require_relative '../../../lib/handlers/basic_handler'

# BasicHandler unit tests class
class UnitTestsBasicHandler < Minitest::Test

  def setup
    # Broker in string
    @broker_value_string = "127.0.0.1:5672"
    # Broker in class
    @broker_value = Qpid::Proton.uri(@broker_value_string)
    # Allowed SASL mechanisms
    @sasl_mechs_value = "SASL"

    @basic_handler_initialization_class = Handlers::BasicHandler.new(
      @broker_value,
      @sasl_mechs_value
    )
  end # setup

  def test_basic_handler_broker_argument_initialization_string
    basic_handler_initialization_string = Handlers::BasicHandler.new(
      @broker_value_string,
      @sasl_mechs_value
    )

    assert_equal(
      @broker_value.to_s,
      basic_handler_initialization_string.broker.to_s
    )
  end # test_basic_handler_broker_argument_initialization_string

  def test_basic_handler_broker_argument_initialization_class
    assert_equal(
      @broker_value.to_s,
      @basic_handler_initialization_class.broker.to_s
    )
  end # test_basic_handler_broker_argument_initialization_class

  def test_basic_handler_sasl_mechs_argument_initialization
    assert_equal(
      @sasl_mechs_value,
      @basic_handler_initialization_class.sasl_mechs
    )
  end # test_basic_handler_sasl_mechs_argument_initialization

end # class UnitTestsBasicHandler

# eof
