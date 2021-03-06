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

require 'optparse'
require 'ostruct'

require_relative '../defaults'
require_relative '../utils/exit_timer'

module Options

  BOOLEAN_STRINGS = %w(true True yes false False no)
  LOG_LIB_STRINGS = %w(NONE TRANSPORT_RAW TRANSPORT_FRM TRANSPORT_DRV)

  # Option parser of basic options for all clients
  # ==== Basic client options
  # broker:: URI of broker in format IP:PORT (default: DEFAULT_BROKER,
  #          see Defaults)
  # conn-allowed-mechs:: allowed SASL mechanisms for authentication
  # help:: show help message and exit
  class BasicOptionParser

    # Client options
    attr_accessor :options

    # Initialization of basic client options
    def initialize()
      @options = OpenStruct.new
      # Basic client's options with default values

      # Broker in format IP:PORT option
      @options.broker = Defaults::DEFAULT_BROKER
      # Exit timer
      @options.exit_timer = Defaults::DEFAULT_EXIT_TIMER
      # Allowed SASL mechanisms
      @options.sasl_mechs = Defaults::DEFAULT_SASL_MECHS
      # Idle timeout
      @options.idle_timeout = Defaults::DEFAULT_IDLE_TIMEOUT
      # Max frame size
      @options.max_frame_size = Defaults::DEFAULT_MAX_FRAME_SIZE
      # SASL enabled
      @options.sasl_enabled = Defaults::DEFAULT_SASL_ENABLED
      # Client library logging
      @options.log_lib = Defaults::DEFAULT_LOG_LIB

      @opt_parser = OptionParser.new
      # Basic usage
      @opt_parser.banner = "Usage: <basic_program> [OPTIONS]"

      @opt_parser.separator ""
      # Broker
      @opt_parser.on(
        "-b",
        "--broker BROKER",
        String,
        "URI of broker in format IP:PORT "+
        "(default: #{Defaults::DEFAULT_BROKER})"
      ) do |broker|
        @options.broker = broker
      end

      # Client exits after this timeout.
      # Handlers can restart the timer
      # (e.g. on receiving messages, making connections etc.)
      @opt_parser.on(
        "-t",
        "--timeout TIMEOUT",
        Float,
        "timeout in seconds to wait before exiting, 0 unlimited (default: 0)"
      ) do |timeout|
        @options.exit_timer = ExitTimer.new(timeout) if timeout > 0
      end

      # Allowed SASL mechanisms
      @opt_parser.on(
        "--conn-allowed-mechs MECHS",
        String,
        "space separated list of SASL mechanisms allowed by client "+
        "for authentication (ANONYMOUS/PLAIN/EXTERNAL, default: "+
        "'#{Defaults::DEFAULT_SASL_MECHS}')"
      ) do |sasl_mechs|
        @options.sasl_mechs = sasl_mechs
      end

      # Max frame size
      @opt_parser.on(
        "--conn-max-frame-size SIZE",
        Integer,
        "define custom maximum frame size in bytes " +
        "(range: #{Defaults::DEFAULT_MIN_MAX_FRAME_SIZE}-" +
        "#{Defaults::DEFAULT_MAX_MAX_FRAME_SIZE}, " +
        "default: #{Defaults::DEFAULT_MAX_FRAME_SIZE})",
      ) do |max_frame_size|
        if max_frame_size < Defaults::DEFAULT_MIN_MAX_FRAME_SIZE \
          or max_frame_size > Defaults::DEFAULT_MAX_MAX_FRAME_SIZE
          raise OptionParser::InvalidArgument, "#{max_frame_size} " +
            "(out of range: #{Defaults::DEFAULT_MIN_MAX_FRAME_SIZE}-" +
            "#{Defaults::DEFAULT_MAX_MAX_FRAME_SIZE})"
        end
        @options.max_frame_size = max_frame_size
      end

      # Heartbeats configuration
      @opt_parser.on(
        "--conn-heartbeat HEARTBEAT",
        Integer,
        "enable and set connection heartbeat, " +
        "default: #{Defaults::DEFAULT_IDLE_TIMEOUT})"
      ) do |idle_timeout|
        @options.idle_timeout = idle_timeout
      end

      # Connection SASL enabled
      @opt_parser.on(
        "--conn-sasl-enabled [ENABLED]",
        Options::BOOLEAN_STRINGS,
        "enable connection SASL (#{Options::BOOLEAN_STRINGS.join("/")}, "+
        "default: #{Defaults::DEFAULT_SASL_ENABLED})"
      ) do |sasl_enabled|
        @options.sasl_enabled = true
        @options.sasl_enabled = StringUtils.str_to_bool(sasl_enabled) if sasl_enabled
      end

      # Client library logging
      @opt_parser.on(
        "--log-lib LEVEL",
        LOG_LIB_STRINGS,
        "enable client library logging (#{LOG_LIB_STRINGS.join("/")}, " +
        "default: #{Defaults::DEFAULT_LOG_LIB})"
      ) do |log_lib|
        @options.log_lib = log_lib
      end

      # Help
      @opt_parser.on_tail(
        "-h",
        "--help",
        "show help message and exit"
      ) do
        puts @opt_parser
        exit
      end
    end

    # Parsing of basic options for all clients
    # ==== Parameters
    # args:: arguments to parse
    def parse(args)
      @opt_parser.parse(args)
    end

  end # class BasicOptionParser

end # module Options

# eof
