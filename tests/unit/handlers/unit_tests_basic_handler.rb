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
    @broker_value = "127.0.0.1:5672"

    @basic_handler_initialization = Handlers::BasicHandler.new(@broker_value)
  end # setup

  def test_basic_handler_broker_argument_initialization
    assert_equal(@broker_value, @basic_handler_initialization.broker)
  end # test_basic_handler_broker_argument_initialization

end # class UnitTestsBasicHandler

# eof
