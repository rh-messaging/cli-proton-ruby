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

require_relative 'sr_common_option_parser'
require_relative '../utils'

module Options

  # Option parser of basic (see Options::BasicOptionParser),
  # common (see Options::SRCommonOptionParser)
  # and specific options for sender client
  # ==== Specific sender options
  # count:: number of messages to send (default: DEFAULT_COUNT, see Defaults)
  # msg-content:: message content (default: DEFAULT_MSG_CONTENT,
  #               see Defaults)
  # msg-correlation-id:: message correlation ID
  # msg-content-map-item:: message content map item
  # msg-group-id:: message group ID
  class SenderOptionParser < Options::SRCommonOptionParser

    # Initialization and parsing of basic, common and specific sender options
    # ==== Parameters
    # args:: arguments to parse
    def initialize(args)
      # Initialization of basic and common options
      super()
      # Sender usage
      @opt_parser.banner = "Usage: <sender_program> [OPTIONS]"

      # Sender specific options with default values
   
      # Number of messages option
      @options.count = Defaults::DEFAULT_COUNT
      # Message content option
      @options.msg_content = Defaults::DEFAULT_MSG_CONTENT
      # Message correlation ID option
      @options.msg_correlation_id = Defaults::DEFAULT_CORR_ID
      # Message group ID option
      @options.msg_group_id = Defaults::DEFAULT_GROUP_ID

      # Number of messages
      @opt_parser.on(
        "-c",
        "--count COUNT",
        Integer,
        "number of messages to send (default: #{Defaults::DEFAULT_COUNT})"
      ) do |count|
        @options.count = count
      end

      # Message content
      @opt_parser.on(
        "-m",
        "--msg-content CONTENT",
        String,
        "message content (default: "+(
          if Defaults::DEFAULT_MSG_CONTENT.nil?
            "nil"
          else
            Defaults::DEFAULT_MSG_CONTENT
          end
        )+")"
      ) do |msg_content|
        @options.msg_content = msg_content
      end

      # Message map content
      @opt_parser.on(
        "-M",
        "--msg-content-map-item KEY=VALUE",
        String,
        "map item specified as KEY=VALUE (use '~' instead of '=' for auto-casting)"
      ) do |msg_content_map_item|
        if @options.msg_content.nil?
          @options.msg_content = {}
        end

        if msg_content_map_item.include? "="
          key, value = msg_content_map_item.split("=")

          @options.msg_content[key] = value.nil? ? "" : value
        elsif msg_content_map_item.include? "~"
          key, value = msg_content_map_item.split("~")

          if value.include? "."
            value = value.to_f
          else
            value = value.to_i
          end

          @options.msg_content[key] = value
        end
      end

      # Message list content
      @opt_parser.on(
        "-L",
        "--msg-content-list-item VALUE",
        "list item"
      ) do |msg_content_list_item|
        if @options.msg_content.nil?
          @options.msg_content = []
        end

        if msg_content_list_item.start_with? "~"
          value = msg_content_list_item[1..-1]
          
          if Utils.str_is_int?(value)
            @options.msg_content.push(value.to_i)
          elsif Utils.str_is_float?(value)
            @options.msg_content.push(value.to_f)
          else
            @options.msg_content.push(value)
          end
        else
          @options.msg_content.push(msg_content_list_item)
        end
      end

      # Message correlation id
      @opt_parser.on(
        "--msg-correlation-id ID",
        String,
        "message correlation ID"
      ) do |msg_correlation_id|
        @options.msg_correlation_id = msg_correlation_id
      end

      # Message group id
      @opt_parser.on(
        "--msg-group-id ID",
        String,
        "message group ID"
      ) do |msg_group_id|
        @options.msg_group_id = msg_group_id
      end

      # Parse basic, common and specific options for sender client
      parse(args)
    end # initialize(args)

  end # class SenderOptionParser

end # module Options

# eof
