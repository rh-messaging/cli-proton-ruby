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
require_relative '../../../lib/handlers/connector_handler'

# ConnectorHandler unit tests class
class UnitTestsConnectorHandler < Minitest::Test

  def setup
    @broker_value = "127.0.0.1:5672"
    @count_value = 1

    @connector_handler_initialization = Handlers::ConnectorHandler.new(
      @broker_value,
      @count_value
    )
  end # setup

  def test_connector_handler_broker_argument_initialization
    assert_equal(@broker_value, @connector_handler_initialization.broker)
  end # test_connector_handler_broker_argument_initialization

  def test_connector_handler_count_argument_initialization
    assert_equal(@count_value, @connector_handler_initialization.count)
  end # test_connector_handler_count_argument_initialization

  def test_connector_handler_connections_initialization
    assert_equal(0, @connector_handler_initialization.connections.length)
  end # test_connector_handler_connections_initialization

end # class UnitTestsConnectorHandler

# eof
