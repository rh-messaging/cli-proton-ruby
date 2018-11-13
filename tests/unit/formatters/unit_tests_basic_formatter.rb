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

require 'digest'
require 'qpid_proton'
require 'minitest/autorun'

require_relative '../../../lib/formatters/basic_formatter'

# BasicFormatter unit tests class
class UnitTestsBasicFormatter < Minitest::Test

  # Class for testing raised exception
  # and exception message
  class MyRaiseTest
  end # MyRaiseTest

  def test_basic_formatter_initialization_message
    message_object = Qpid::Proton::Message.new(nil)
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal(message_object, basic_formatter.message)
  end # test_basic_formatter_initialization_message

  def test_basic_formatter_initialization_message_and_msg_content_hashed
    message_object = Qpid::Proton::Message.new(nil)
    basic_formatter = Formatters::BasicFormatter.new(message_object, true)
    assert_equal(message_object, basic_formatter.message)
    assert_equal(true, basic_formatter.msg_content_hashed)
  end # test_basic_formatter_initialization_message_and_msg_content_hashed

  def test_basic_formatter_true_format
    message_object = Qpid::Proton::Message.new(true)
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal("True", basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_true_format

  def test_basic_formatter_true_in_string_format
    message_object = Qpid::Proton::Message.new("true")
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal("'true'", basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_true_in_string_format

  def test_basic_formatter_false_format
    message_object = Qpid::Proton::Message.new(false)
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal("False", basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_false_format

  def test_basic_formatter_false_in_string_format
    message_object = Qpid::Proton::Message.new("false")
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal("'false'", basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_false_in_string_format

  def test_basic_formatter_integer_format
    message_object = Qpid::Proton::Message.new(1)
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal(1, basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_integer_format

  def test_basic_formatter_integer_in_string_format
    message_object = Qpid::Proton::Message.new("1")
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal("'1'", basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_integer_in_string_format

  def test_basic_formatter_float_format
    message_object = Qpid::Proton::Message.new(1.0)
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal(1.0, basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_float_format

  def test_basic_formatter_float_in_string_format
    message_object = Qpid::Proton::Message.new("1.0")
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal("'1.0'", basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_float_in_string_format

  def test_basic_formatter_range_format
    message_object = Qpid::Proton::Message.new(1..10)
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal(1..10, basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_range_format

  def test_basic_formatter_range_in_string_format
    message_object = Qpid::Proton::Message.new("1..10")
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal("'1..10'", basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_range_in_string_format

  def test_basic_formatter_empty_array_format
    message_object = Qpid::Proton::Message.new([])
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal("[]", basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_empty_array_format

  def test_basic_formatter_empty_array_in_string_format
    message_object = Qpid::Proton::Message.new("[]")
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal("'[]'", basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_empty_array_in_string_format

  def test_basic_formatter_basic_array_format
    message_object = Qpid::Proton::Message.new(["A", "B", "C"])
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal(
      "['A', 'B', 'C']",
      basic_formatter.format_value(message_object.body)
    )
  end # test_basic_formatter_basic_array_format

  def test_basic_formatter_basic_array_in_string_format
    message_object = Qpid::Proton::Message.new("['A', 'B', 'C']")
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal(
      "'[\\'A\\', \\'B\\', \\'C\\']'",
      basic_formatter.format_value(message_object.body)
    )
  end # test_basic_formatter_basic_array_in_string_format

  def test_basic_formatter_empty_hash_format
    message_object = Qpid::Proton::Message.new({})
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal("{}", basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_empty_hash_format

  def test_basic_formatter_empty_hash_in_string_format
    message_object = Qpid::Proton::Message.new("{}")
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal("'{}'", basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_empty_hash_in_string_format

  def test_basic_formatter_basic_hash_format
    message_object = Qpid::Proton::Message.new({1=>"A", 2=>"B", 3=>"C"})
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal(
      "{1: 'A', 2: 'B', 3: 'C'}",
      basic_formatter.format_value(message_object.body)
    )
  end # test_basic_formatter_basic_hash_format

  def test_basic_formatter_basic_dict_in_string_format
    message_object = Qpid::Proton::Message.new(
      "{1: 'A', 2: 'B', 3: 'C'}"
    )
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal(
      "'{1: \\'A\\', 2: \\'B\\', 3: \\'C\\'}'",
      basic_formatter.format_value(message_object.body)
    )
  end # test_basic_formatter_basic_dict_in_string_format

  def test_basic_formatter_empty_string_format
    message_object = Qpid::Proton::Message.new("")
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal("None", basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_basic_string_format

  def test_basic_formatter_basic_string_format
    message_object = Qpid::Proton::Message.new("unit_test")
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal(
      "'unit_test'",
      basic_formatter.format_value(message_object.body)
    )
  end # test_basic_formatter_basic_string_format

  def test_basic_formatter_symbol_format
    message_object = Qpid::Proton::Message.new(:ruby_symbol)
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal(
      "'ruby_symbol'",
      basic_formatter.format_value(message_object.body)
    )
  end # test_basic_formatter_symbol_format

  def test_basic_formatter_nil_format
    message_object = Qpid::Proton::Message.new(nil)
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_equal("None", basic_formatter.format_value(message_object.body))
  end # test_basic_formatter_nil_format

  def test_basic_formatter_raise_type_error
    message_object = Qpid::Proton::Message.new(MyRaiseTest.new)
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    assert_raises TypeError do
      basic_formatter.format_value(message_object.body)
    end
  end # test_basic_formatter_raise_type_error

  def test_basic_formatter_raise_type_error_message
    message_object = Qpid::Proton::Message.new(MyRaiseTest.new)
    basic_formatter = Formatters::BasicFormatter.new(message_object)
    exception = assert_raises TypeError do
      basic_formatter.format_value(message_object.body)
    end
    assert_equal("Unknown value type", exception.message)
  end # test_basic_formatter_raise_type_error_message

  def test_basic_formatter_hashed_content
    value = "text_to_hash"
    message_object = Qpid::Proton::Message.new(value)
    basic_formatter = Formatters::BasicFormatter.new(message_object, true)
    hashed_value = basic_formatter.format_value(Digest::SHA1.hexdigest(value))+"\n"
    my_output = StringIO.new
    $stdout = my_output
    basic_formatter.print
    assert_equal(hashed_value, $stdout.string)
  end # test_basic_formatter_hashed_content

  def test_escape
    assert_equal("some message", Formatters::BasicFormatter.escape_chars("some message"))
    assert_equal("a\\u0000b\\nc", Formatters::BasicFormatter.escape_chars("a\0b\nc"))
  end # test_basic_formatter_hashed_content

end # class UnitTestsBasicFormatter

# eof
