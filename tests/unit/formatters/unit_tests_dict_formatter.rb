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

require_relative '../../../lib/formatters/dict_formatter'

# DictFormatter unit tests class
class UnitTestsDictFormatter < Minitest::Test

  def test_dict_formatter_initialization
    message_object = Qpid::Proton::Message.new(nil)
    dict_formatter = Formatters::DictFormatter.new(message_object)
    assert_equal(message_object, dict_formatter.message)
  end # test_dict_formatter_initialization

  def test_dict_formatter_basic_message_format
    message_object = Qpid::Proton::Message.new()
    dict_formatter = Formatters::DictFormatter.new(message_object)
    assert_equal(
      "{'redelivered': False, "\
      + "'reply_to': None, "\
      + "'subject': None, "\
      + "'content_type': None, "\
      + "'id': None, "\
      + "'group_id': None, "\
      + "'user_id': None, "\
      + "'correlation_id': None, "\
      + "'priority': 4, "\
      + "'durable': False, "\
      + "'ttl': 0, "\
      + "'properties': {}, "\
      + "'content': None}",
      dict_formatter.get_as_dictionary()
    )
  end # test_dict_formatter_basic_message_format

end # class UnitTestsDictFormatter

# eof
