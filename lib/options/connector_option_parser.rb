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

  # Option parser of basic (see Options::BasicOptionParser) and specific
  # options for connector client
  # ==== Specific connector options
  # count:: number of connections to create (default: DEFAULT_COUNT,
  #         see Constants)
  class ConnectorOptionParser < Options::BasicOptionParser

    # Initialization and parsing of basic and specific connector options
    # ==== Parameters
    # args:: arguments to parse
    def initialize(args)
      # Initialization of basic options
      super()
      # Connector usage
      @opt_parser.banner = "Usage: <connector_program> [OPTIONS]"

      # Connector specific options with default values

      # Number of connections option
      @options.count = Constants::DEFAULT_COUNT

      # Number of messages
      @opt_parser.on(
        "-c",
        "--count COUNT",
        Integer,
        "number of connections to create"+
        "(default: #{Constants::DEFAULT_COUNT})"
      ) do |count|
        @options.count = count
      end

      # Parse basic and specific options for connector client
      parse(args)
    end # initialize(args)

  end # class ConnectorOptionParser

end # module Options

# eof
