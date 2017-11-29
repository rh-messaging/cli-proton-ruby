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

module Options

  # Option parser of basic options for all clients
  # ==== Basic client options
  # broker:: URL of broker in format IP:PORT (default: DEFAULT_BROKER,
  #          see Constants)
  # help:: show help message and exit
  class BasicOptionParser

    # Client options
    attr_accessor :options

    # Initialization of basic client options
    def initialize()
      @options = OpenStruct.new
      # Basic client's options with default values

      # Broker in format IP:PORT option
      @options.broker = Constants::DEFAULT_BROKER

      @opt_parser = OptionParser.new
      # Basic usage
      @opt_parser.banner = "Usage: <basic_program> [OPTIONS]"

      @opt_parser.separator ""
      # Broker
      @opt_parser.on(
        "-b",
        "--broker BROKER",
        String,
        "URL of broker in format IP:PORT "+
        "(default: #{Constants::DEFAULT_BROKER})"
      ) do |broker|
        @options.broker = broker
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
    end # initialize()

    # Parsing of basic options for all clients
    # ==== Parameters
    # args:: arguments to parse
    def parse(args)
      @opt_parser.parse(args)
    end # parse(args)

  end # class BasicOptionParser

end # module Options

# eof
