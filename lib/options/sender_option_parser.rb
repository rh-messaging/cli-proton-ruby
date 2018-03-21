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
require_relative '../utils/string_utils'

module Options

  # Option parser of basic (see Options::BasicOptionParser),
  # common (see Options::SRCommonOptionParser)
  # and specific options for sender client
  # ==== Specific sender options
  # count:: number of messages to send (default: DEFAULT_COUNT, see Defaults)
  # msg-content:: message content (default: DEFAULT_MSG_CONTENT,
  #               see Defaults)
  # msg-content-map-item:: message content map item
  # msg-content-list-item:: message content list item
  # msg-durable:: message durability (default: DEFAULT_MSG_DURABLE)
  # msg-ttl:: message Time-To-Live (ms) (default: DEFAULT_MSG_TTL)
  # msg-correlation-id:: message correlation ID
  # msg-reply-to:: address to send reply to
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
      # Message property option
      @options.msg_properties = Defaults::DEFAULT_MSG_PROPERTIES
      # Message content option
      @options.msg_content = Defaults::DEFAULT_MSG_CONTENT
      # Message content type option
      @options.msg_content_type = Defaults::DEFAULT_MSG_CONTENT_TYPE
      # Content type option
      @options.content_type = Defaults::DEFAULT_CONTENT_TYPE
      # Message durability
      @options.msg_durable = Defaults::DEFAULT_MSG_DURABLE
      # Message TTL
      @options.msg_ttl = Defaults::DEFAULT_MSG_TTL
      # Message correlation ID option
      @options.msg_correlation_id = Defaults::DEFAULT_CORR_ID
      # Address to send reply to
      @options.msg_reply_to = Defaults::DEFAULT_MSG_REPLY_TO
      # Message group ID option
      @options.msg_group_id = Defaults::DEFAULT_GROUP_ID
      # Message priority option
      @options.msg_priority = Defaults::DEFAULT_MSG_PRIORITY
      # Message ID option
      @options.msg_id = Defaults::DEFAULT_MSG_ID
      # Message user ID option
      @options.msg_user_id = Defaults::DEFAULT_MSG_USER_ID
      # Message subject option
      @options.msg_subject = Defaults::DEFAULT_MSG_SUBJECT
      # Anonymous producer option
      @options.anonymous = Defaults::DEFAULT_ANONYMOUS

      # List of blocks executed at the end of parsing
      # when all other options are already applied
      @do_last = []

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
        @do_last << Proc.new {
          @options.msg_content = manual_cast(@options.content_type, msg_content)
        }
      end

      # Message content from file
      @opt_parser.on(
        "--msg-content-from-file FILE",
        String,
        "message content from file"
      ) do |file|
        @do_last << Proc.new {
          @options.msg_content = manual_cast(@options.content_type, File.read(file))
        }
      end

      # Message content type
      @opt_parser.on(
        "--msg-content-type TYPE",
        String,
        "AMQP message content type"
      ) do |msg_content_type|
        @options.msg_content_type = msg_content_type
      end

      # Content type
      @opt_parser.on(
        "--content-type TYPE",
        %w(string int long float bool),
        "cast --msg-content, -list-item, and =values of -map-item" +
        "and --msg-property to this type (default: #{Defaults::DEFAULT_CONTENT_TYPE})"
      ) do |content_type|
        @options.content_type = content_type
      end

      # Message property
      @opt_parser.on(
        "-P",
        "--msg-property KEY=VALUE",
        String,
        "property specified as KEY=VALUE (use '~' instead of '=' for auto-casting)"
      ) do |msg_property|
        _ = parse_kv(msg_property)  # ensure correct option format
        @do_last << Proc.new {
          if @options.msg_properties.nil?
            @options.msg_properties = {}
          end

          key, value = parse_kv(msg_property)
          @options.msg_properties[key] = value
        }
      end
      # Message map content
      @opt_parser.on(
        "-M",
        "--msg-content-map-item KEY=VALUE",
        String,
        "map item specified as KEY=VALUE (use '~' instead of '=' for auto-casting)"
      ) do |msg_content_map_item|
        _ = parse_kv(msg_content_map_item)  # ensure correct option format
        @do_last << Proc.new {
          if @options.msg_content.nil?
            @options.msg_content = {}
          end

          key, value = parse_kv(msg_content_map_item)
          @options.msg_content[key] = value
        }
      end

      # Message list content
      @opt_parser.on(
        "-L",
        "--msg-content-list-item VALUE",
        "list item"
      ) do |msg_content_list_item|
        @do_last << Proc.new {
          if @options.msg_content.nil?
            @options.msg_content = []
          end

          if msg_content_list_item.start_with? "~"
            value = msg_content_list_item[1..-1]
            @options.msg_content.push(auto_cast(value))
          else
           @options.msg_content.push(
                manual_cast(@options.content_type, msg_content_list_item))
          end
        }
      end

      # Message durability
      @opt_parser.on(
        "--msg-durable DURABILITY",
        BOOLEAN_STRINGS,
        "message durability (yes/no|True/False|true/false, default: "+
        "#{Defaults::DEFAULT_MSG_DURABLE})"
      ) do |msg_durable|
        @options.msg_durable = StringUtils.str_to_bool?(msg_durable)
      end

      # Message TTL
      @opt_parser.on(
        "--msg-ttl TTL",
        Integer,
        "message Time-To-Live (ms) (default: #{Defaults::DEFAULT_MSG_TTL})"
      ) do |msg_ttl|
        @options.msg_ttl = msg_ttl
      end

      # Message correlation id
      @opt_parser.on(
        "--msg-correlation-id ID",
        String,
        "message correlation ID"
      ) do |msg_correlation_id|
        @options.msg_correlation_id = msg_correlation_id
      end

      # Address to send reply to
      @opt_parser.on(
        "--msg-reply-to ADDRESS",
        String,
        "address to send reply to"
      ) do |msg_reply_to|
        @options.msg_reply_to = msg_reply_to
      end

      # Message group id
      @opt_parser.on(
        "--msg-group-id ID",
        String,
        "message group ID"
      ) do |msg_group_id|
        @options.msg_group_id = msg_group_id
      end

      # Message priority
      @opt_parser.on(
        "--msg-priority PRIORITY",
        Integer,
        "message priority"
      ) do |msg_priority|
        @options.msg_priority = msg_priority
      end

      # Message ID
      @opt_parser.on(
        "--msg-id ID",
        String,
        "message ID"
      ) do |msg_id|
        @options.msg_id = msg_id
      end

      # Message user ID
      @opt_parser.on(
        "--msg-user-id ID",
        String,
        "message user ID"
      ) do |msg_user_id|
        @options.msg_user_id = msg_user_id
      end

      # Message subject
      @opt_parser.on(
        "--msg-subject SUBJECT",
        String,
        "message subject"
      ) do |msg_subject|
        @options.msg_subject = msg_subject
      end

      # Anonymous producer
      @opt_parser.on(
        "--anonymous ANONYMOUS",
        BOOLEAN_STRINGS,
        "send message by connection level anonymous sender" +
        " (default: #{Defaults::DEFAULT_ANONYMOUS})"
      ) do |anonymous|
        @options.anonymous = StringUtils.str_to_bool?(anonymous)
      end

      # Parse basic, common and specific options for sender client
      parse(args)
      # Apply options which need to be applied last
      @do_last.each { |proc| proc.call }
    end # initialize

    private
    def parse_kv(key_value)
      if key_value.include? "="
        key, value = key_value.split("=")
        value = "" if value.nil?
        return key, manual_cast(@options.content_type, value)
      elsif key_value.include? "~"
        key, value = key_value.split("~")
        return key, auto_cast(value)
      else
        raise OptionParser::InvalidArgument, "kv pair '#{key_value}' is of invalid format, = or ~ required"
      end
    end

    private
    def auto_cast(value)
      if StringUtils.str_is_int?(value)
        return value.to_i
      elsif StringUtils.str_is_float?(value)
        return value.to_f
      end
      return value
    end

    private
    def manual_cast(type, value)
      case type
      when "int"
        return Integer(value)
      when "float"
        return Float(value)
      when "long"
        return Integer(value)
      when "bool"
        t = /[tT]rue/.match? value
        f = /[fF]alse/.match? value
        unless t or f
          raise ArgumentError, "invalid value for Boolean(): \"#{value}\""
        end
        return t
      else
        return value
      end
    end

  end # class SenderOptionParser

end # module Options

# eof
