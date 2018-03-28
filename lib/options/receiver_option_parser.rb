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
require_relative '../constants'
require_relative '../utils/string_utils'

module Options

  # Option parser of basic (see Options::BasicOptionParser),
  # common (see Options::SRCommonOptionParser)
  # and specific options for receiver client
  # ==== Specific receiver options
  # count:: number of messages to receiver
  #         (default: DEFAULT_COUNT, see Defaults)
  # process-reply-to:: send message to reply-to address if enabled
  #                    and message got reply-to address
  # recv-browse:: browse messages instead of reading
  #               (default: DEFAULT_BROWSE, see Defaults)
  class ReceiverOptionParser < Options::SRCommonOptionParser

    # Initialization and parsing of basic, common and specific receiver
    # options
    # ==== Parameters
    # args:: arguments to parse
    def initialize(args)
      # Initialization of basic and common options
      super()
      # Receiver usage
      @opt_parser.banner = "Usage: <receiver_program> [OPTIONS]"

      # Receiver specific options with default values

      # Number of messages option
      @options.count = Defaults::DEFAULT_COUNT
      # Process reply to
      @options.process_reply_to = Defaults::DEFAULT_PROC_REPLY_TO
      # Browse messages
      @options.browse = Defaults::DEFAULT_BROWSE
      # Receiver listen
      @options.recv_listen = Defaults::DEFAULT_RECV_LISTEN
      # Receiver listen port
      @options.recv_listen_port = Defaults::DEFAULT_RECV_LISTEN_PORT

      # Number of messages
      @opt_parser.on(
        "-c",
        "--count COUNT",
        Integer,
        "number of messages to receiver "+
        "(default: #{Defaults::DEFAULT_COUNT})"
      ) do |count|
        @options.count = count
      end

      # Process reply to
      @opt_parser.on(
        "--process-reply-to",
        "send message to reply-to address if enable and message got reply-to "+
        "address",
      ) do |process_reply_to|
        @options.process_reply_to = process_reply_to
      end

      # Browse messages
      @opt_parser.on(
        "--recv-browse",
        "browse messages instead of reading",
      ) do |browse|
        @options.browse = browse
      end

      # Receiver listen
      @opt_parser.on(
        "--recv-listen LISTEN",
        Options::BOOLEAN_STRINGS,
        "enable receiver listen (P2P) (#{Options::BOOLEAN_STRINGS.join("/")}, "+
        "default: #{Defaults::DEFAULT_RECV_LISTEN})"
      ) do |recv_listen|
        @options.recv_listen = StringUtils.str_to_bool?(recv_listen)
      end

      # Receiver listen port
      @opt_parser.on(
        "--recv-listen-port PORT",
        Integer,
        "define port for local listening "+
        "(range: #{Constants::CONST_MIN_PORT_RANGE_VALUE}-"+
        "#{Constants::CONST_MAX_PORT_RANGE_VALUE}, "+
        "default: #{Defaults::DEFAULT_RECV_LISTEN_PORT})"
      ) do |recv_listen_port|
        if recv_listen_port < Constants::CONST_MIN_PORT_RANGE_VALUE \
          or recv_listen_port > Constants::CONST_MAX_PORT_RANGE_VALUE
          raise OptionParser::InvalidArgument, "#{recv_listen_port} "+
            "(out of range: #{Constants::CONST_MIN_PORT_RANGE_VALUE}-"+
            "#{Constants::CONST_MAX_PORT_RANGE_VALUE})"
        end
        @options.recv_listen_port = recv_listen_port
      end

      # Parse basic, common and specific options for receiver client
      parse(args)
    end # initialize(args)

  end # class ReceiverOptionParser

end # module Options

# eof
