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

require_relative 'basic_option_parser'

module Options

  # Option parser of basic (see Options::BasicOptionParser) and common
  # options for sender and receiver client
  # ==== Common sender and receiver options
  # log-msgs:: format of message(s) log (none/body/dict,
  #            default: DEFAULT_LOG_MSGS, see Defaults)
  class SRCommonOptionParser < Options::BasicOptionParser

    # Initialization of basic and common sender and receiver options
    def initialize()
      # Initialization of basic options
      super()
      # SR usage
      @opt_parser.banner = "Usage: <sr_program> [OPTIONS]"

      # SR specific options with default values

      # Format of message log option
      @options.log_msgs = Defaults::DEFAULT_LOG_MSGS
      # Hash message content
      @options.msg_content_hashed = Defaults::DEFAULT_MSG_CONTENT_HASHED
      # Auto settle off
      @options.auto_settle_off = Defaults::DEFAULT_AUTO_SETTLE_OFF

      # Format of message log
      @opt_parser.on(
        "--log-msgs FORMAT",
        %w(none body dict interop),
        "format of message(s) log (none/body/dict/interop, "+
        "default: #{Defaults::DEFAULT_LOG_MSGS})"
      ) do |log_msgs|
        @options.log_msgs = log_msgs
      end

      # Message content hashed
      @opt_parser.on(
        "--msg-content-hashed [HASHED]",
        Options::BOOLEAN_STRINGS,
        "display SHA-1 hash of message content in logged messages (true/false) (default: #{Defaults::DEFAULT_MSG_CONTENT_HASHED})"
      ) do |msg_content_hashed|
        @options.msg_content_hashed = true
        @options.msg_content_hashed = \
          StringUtils.str_to_bool(msg_content_hashed) if msg_content_hashed
      end

      # Auto settle off
      @opt_parser.on(
        "--auto-settle-off [OFF]",
        Options::BOOLEAN_STRINGS,
        "disable auto settle mode (default: #{Defaults::DEFAULT_AUTO_SETTLE_OFF})"
      ) do |auto_settle_off|
        @options.auto_settle_off = true
        @options.auto_settle_off = \
          StringUtils.str_to_bool(auto_settle_off) if auto_settle_off
      end

      @options.duration = 0
      @opt_parser.on(
        "--duration DURATION", Float,
        "message actions total duration (defines msg-rate together with count, default 0)"
      ) do |d|
        @options.duration = d
      end
    end # initialize

    # Parsing of basic and common options for sender and receiver client
    # ==== Parameters
    # args:: arguments to parse
    def parse(args)
      @opt_parser.parse(args)
    end # parse(args)

  end # class SRCommonOptionParser

end # module Options

# eof
