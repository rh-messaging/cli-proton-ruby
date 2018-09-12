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

require_relative '../../../lib/formatters/interop_formatter'

# InteropFormatter unit tests class
class UnitTestsInteropFormatter < Minitest::Test

  def test_interop_formatter_initialization_message
    message_object = Qpid::Proton::Message.new(nil)
    interop_formatter = Formatters::InteropFormatter.new(message_object)
    assert_equal(message_object, interop_formatter.message)
  end # test_interop_formatter_initialization_message

  def test_interop_formatter_initialization_message_and_msg_content_hashed
    message_object = Qpid::Proton::Message.new(nil)
    interop_formatter = Formatters::InteropFormatter.new(message_object, true)
    assert_equal(message_object, interop_formatter.message)
    assert_equal(true, interop_formatter.msg_content_hashed)
  end # test_interop_formatter_initialization_message_and_msg_content_hashed

  def test_interop_formatter_basic_message_format_round_down
    message_object = Qpid::Proton::Message.new()
    message_object.id = 3.141592
    interop_formatter = Formatters::InteropFormatter.new(message_object)
    assert_equal(
      "{'redelivered': False, "\
      + "'reply-to': None, "\
      + "'subject': None, "\
      + "'content-type': None, "\
      + "'id': 3.14159, "\
      + "'group-id': None, "\
      + "'user-id': None, "\
      + "'correlation-id': None, "\
      + "'priority': 4, "\
      + "'durable': False, "\
      + "'ttl': 0, "\
      + "'absolute-expiry-time': 0, "\
      + "'address': None, "\
      + "'content-encoding': None, "\
      + "'delivery-count': 0, "\
      + "'first-acquirer': False, "\
      + "'group-sequence': 0, "\
      + "'reply-to-group-id': None, "\
      + "'to': None, "\
      + "'properties': {}, "\
      + "'content': None}",
      interop_formatter.get_as_interop_dictionary()
    )
  end # test_interop_formatter_basic_message_format_round_down

  def test_interop_formatter_basic_message_format_round_up
    message_object = Qpid::Proton::Message.new()
    message_object.id = 3.141597
    interop_formatter = Formatters::InteropFormatter.new(message_object)
    assert_equal(
      "{'redelivered': False, "\
      + "'reply-to': None, "\
      + "'subject': None, "\
      + "'content-type': None, "\
      + "'id': 3.1416, "\
      + "'group-id': None, "\
      + "'user-id': None, "\
      + "'correlation-id': None, "\
      + "'priority': 4, "\
      + "'durable': False, "\
      + "'ttl': 0, "\
      + "'absolute-expiry-time': 0, "\
      + "'address': None, "\
      + "'content-encoding': None, "\
      + "'delivery-count': 0, "\
      + "'first-acquirer': False, "\
      + "'group-sequence': 0, "\
      + "'reply-to-group-id': None, "\
      + "'to': None, "\
      + "'properties': {}, "\
      + "'content': None}",
      interop_formatter.get_as_interop_dictionary()
    )
  end # test_interop_formatter_basic_message_format_round_up

  def test_interop_formatter_basic_message_format_round_down_hashed
    value = "text_to_hash"
    message_object = Qpid::Proton::Message.new(value)
    message_object.id = 3.141592
    interop_formatter = Formatters::InteropFormatter.new(message_object, true)
    hashed_value = interop_formatter.format_value(Digest::SHA1.hexdigest(value))
    assert_equal(
      "{'redelivered': False, "\
      + "'reply-to': None, "\
      + "'subject': None, "\
      + "'content-type': None, "\
      + "'id': 3.14159, "\
      + "'group-id': None, "\
      + "'user-id': None, "\
      + "'correlation-id': None, "\
      + "'priority': 4, "\
      + "'durable': False, "\
      + "'ttl': 0, "\
      + "'absolute-expiry-time': 0, "\
      + "'address': None, "\
      + "'content-encoding': None, "\
      + "'delivery-count': 0, "\
      + "'first-acquirer': False, "\
      + "'group-sequence': 0, "\
      + "'reply-to-group-id': None, "\
      + "'to': None, "\
      + "'properties': {}, "\
      + "'content': "+hashed_value+"}",
      interop_formatter.get_as_interop_dictionary()
    )
  end # test_interop_formatter_basic_message_format_round_down_hashed

  def test_interop_formatter_basic_message_format_round_up_hashed
    value = "text_to_hash"
    message_object = Qpid::Proton::Message.new(value)
    message_object.id = 3.141597
    interop_formatter = Formatters::InteropFormatter.new(message_object, true)
    hashed_value = interop_formatter.format_value(Digest::SHA1.hexdigest(value))
    assert_equal(
      "{'redelivered': False, "\
      + "'reply-to': None, "\
      + "'subject': None, "\
      + "'content-type': None, "\
      + "'id': 3.1416, "\
      + "'group-id': None, "\
      + "'user-id': None, "\
      + "'correlation-id': None, "\
      + "'priority': 4, "\
      + "'durable': False, "\
      + "'ttl': 0, "\
      + "'absolute-expiry-time': 0, "\
      + "'address': None, "\
      + "'content-encoding': None, "\
      + "'delivery-count': 0, "\
      + "'first-acquirer': False, "\
      + "'group-sequence': 0, "\
      + "'reply-to-group-id': None, "\
      + "'to': None, "\
      + "'properties': {}, "\
      + "'content': "+hashed_value+"}",
      interop_formatter.get_as_interop_dictionary()
    )
  end # test_interop_formatter_basic_message_format_round_up_hashed

end # class UnitTestsInteropFormatter

# eof
