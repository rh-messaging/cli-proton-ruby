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

module Options

  # Option parser of basic (see Options::BasicOptionParser),
  # common (see Options::SRCommonOptionParser)
  # and specific options for receiver client
  # ==== Specific receiver options
  # count:: number of messages to receiver (default: 1)
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
      @options.count = 1

      # Number of messages
      @opt_parser.on(
        "-c",
        "--count COUNT",
        Integer,
        "number of messages to receiver (default: 1)"
      ) do |count|
        @options.count = count
      end

      # Parse basic, common and specific options for receiver client
      parse(args)
    end # initialize(args)

  end # class ReceiverOptionParser

end # module Options

# eof
