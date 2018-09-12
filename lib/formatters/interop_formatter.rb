#--
# Copyright 2018 Red Hat Inc.
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

require_relative 'dict_formatter'

module Formatters

  # Formatter of message into interop dictionary format
  class InteropFormatter < Formatters::DictFormatter

    # Initialization of interop dictionary formatter
    # ==== Interop dictionary formatter arguments
    # message:: message to format
    def initialize(message, msg_content_hashed=false)
      super(message, msg_content_hashed)
    end # initialize(message)

    # Format value according to type
    # ==== Parameters
    # value:: value to format
    # ==== Returns
    # value formatted as string
    def format_value(value)
      case value
      when Float
        # ab_diff = [{'content': [[-1.3, -1.2999999523162842]]}]
        value.round(5)
      else
        super
      end
    end

    # Format message as interop dictionary
    # ==== Returns
    # message formatted as interop dictionary
    def get_as_interop_dictionary()
      dict_to_return = "" \
      + "'redelivered': #{format_value(
        @message.delivery_count == 0 ? false : true
      )}, "\
      + "'reply-to': #{format_value(@message.reply_to)}, "\
      + "'subject': #{format_value(@message.subject)}, "\
      + "'content-type': #{format_value(@message.content_type)}, "\
      + "'id': #{format_value(@message.id)}, "\
      + "'group-id': #{format_value(@message.group_id)}, "\
      + "'user-id': #{format_value(@message.user_id)}, "\
      + "'correlation-id': #{format_value(@message.correlation_id)}, "\
      + "'priority': #{format_value(@message.priority)}, "\
      + "'durable': #{format_value(@message.durable)}, "\
      + "'ttl': #{format_value(@message.ttl)}, "\
      + "'absolute-expiry-time': #{format_value(@message.expires)}, "\
      + "'address': #{format_value(@message.address)}, "\
      + "'content-encoding': #{format_value(@message.content_encoding)}, "\
      + "'delivery-count': #{format_value(@message.delivery_count)}, "\
      + "'first-acquirer': #{format_value(@message.first_acquirer?)}, "\
      + "'group-sequence': #{format_value(@message.group_sequence)}, "\
      + "'reply-to-group-id': #{format_value(@message.reply_to_group_id)}, "\
      + "'to': #{format_value(@message.to)}, "\
      + "'properties': #{format_value(@message.properties)}, "\
      + "'content': #{
        format_value(@msg_content_hashed ? StringUtils.sha1_hash(@message.body) : @message.body)
      }"
      return "{#{dict_to_return}}"
    end # get_as_interop_dictionary()

    # Prints message formatted as interop dictionary to stdout
    def print()
      # Print formatted message to stdout
      puts get_as_interop_dictionary()
    end # print()

  end # class InteropFormatter

end # module Formatters

