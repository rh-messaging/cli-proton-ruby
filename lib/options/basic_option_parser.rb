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
      # Allowed SASL mechanisms
      @options.sasl_mechs = Defaults::DEFAULT_SASL_MECHS

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
