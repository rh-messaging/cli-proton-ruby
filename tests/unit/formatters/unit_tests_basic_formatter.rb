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

require 'qpid_proton'
require 'minitest/autorun'

require_relative '../../../lib/formatters/basic_formatter'

# BasicFormatter unit tests class
class UnitTestsBasicFormatter < Minitest::Test

  # Class for testing raised exception
  # and exception message
  class MyRaiseTest
  end # MyRaiseTest

  def test_basic_formatter_initialization
    messageObject = Qpid::Proton::Message.new(nil)
    basicFormatter = Formatters::BasicFormatter.new(messageObject)
    assert_equal(messageObject, basicFormatter.message)
  end # test_basic_formatter_initialization

  def test_basic_formatter_true_format
    messageObject = Qpid::Proton::Message.new(true)
    basicFormatter = Formatters::BasicFormatter.new(messageObject)
    assert_equal("True", basicFormatter.formatValue(messageObject.body))
  end # test_basic_formatter_true_format

  def test_basic_formatter_false_format
    messageObject = Qpid::Proton::Message.new(false)
    basicFormatter = Formatters::BasicFormatter.new(messageObject)
    assert_equal("False", basicFormatter.formatValue(messageObject.body))
  end # test_basic_formatter_false_format

  def test_basic_formatter_integer_format
    messageObject = Qpid::Proton::Message.new(1)
    basicFormatter = Formatters::BasicFormatter.new(messageObject)
    assert_equal(1, basicFormatter.formatValue(messageObject.body))
  end # test_basic_formatter_integer_format

  def test_basic_formatter_float_format
    messageObject = Qpid::Proton::Message.new(1.0)
    basicFormatter = Formatters::BasicFormatter.new(messageObject)
    assert_equal(1.0, basicFormatter.formatValue(messageObject.body))
  end # test_basic_formatter_float_format

  def test_basic_formatter_range_format
    messageObject = Qpid::Proton::Message.new(1..10)
    basicFormatter = Formatters::BasicFormatter.new(messageObject)
    assert_equal(1..10, basicFormatter.formatValue(messageObject.body))
  end # test_basic_formatter_range_format

  def test_basic_formatter_basic_array_format
    messageObject = Qpid::Proton::Message.new(["A", "B", "C"])
    basicFormatter = Formatters::BasicFormatter.new(messageObject)
    assert_equal("[\"A\", \"B\", \"C\"]", basicFormatter.formatValue(messageObject.body))
  end # test_basic_formatter_basic_array_format

  def test_basic_formatter_basic_hash_format
    messageObject = Qpid::Proton::Message.new({1=>"A", 2=>"B", 3=>"C"})
    basicFormatter = Formatters::BasicFormatter.new(messageObject)
    assert_equal("{1: \"A\", 2: \"B\", 3: \"C\"}", basicFormatter.formatValue(messageObject.body))
  end # test_basic_formatter_basic_hash_format

  def test_basic_formatter_basic_string_format
    messageObject = Qpid::Proton::Message.new("unit_test")
    basicFormatter = Formatters::BasicFormatter.new(messageObject)
    assert_equal("\"unit_test\"", basicFormatter.formatValue(messageObject.body))
  end # test_basic_formatter_basic_string_format

  def test_basic_formatter_symbol_format
    messageObject = Qpid::Proton::Message.new(:ruby_symbol)
    basicFormatter = Formatters::BasicFormatter.new(messageObject)
    assert_equal("\"ruby_symbol\"", basicFormatter.formatValue(messageObject.body))
  end # test_basic_formatter_symbol_format

  def test_basic_formatter_nil_format
    messageObject = Qpid::Proton::Message.new(nil)
    basicFormatter = Formatters::BasicFormatter.new(messageObject)
    assert_equal("None", basicFormatter.formatValue(messageObject.body))
  end # test_basic_formatter_nil_format

  def test_basic_formatter_raise_type_error
    messageObject = Qpid::Proton::Message.new(MyRaiseTest.new)
    basicFormatter = Formatters::BasicFormatter.new(messageObject)
    assert_raises TypeError do
      basicFormatter.formatValue(messageObject.body)
    end
  end # test_basic_formatter_raise_type_error

  def test_basic_formatter_raise_type_error_message
    messageObject = Qpid::Proton::Message.new(MyRaiseTest.new)
    basicFormatter = Formatters::BasicFormatter.new(messageObject)
    exception = assert_raises TypeError do
      basicFormatter.formatValue(messageObject.body)
    end
    assert_equal("Unknown value type", exception.message)
  end # test_basic_formatter_raise_type_error_message

end # class UnitTestsBasicFormatter

# eof
