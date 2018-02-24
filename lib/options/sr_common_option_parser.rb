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
  #            default: DEFAULT_LOG_MSGS, see Constants)
  class SRCommonOptionParser < Options::BasicOptionParser

    # Initialization of basic and common sender and receiver options
    def initialize()
      # Initialization of basic options
      super()
      # SR usage
      @opt_parser.banner = "Usage: <sr_program> [OPTIONS]"

      # SR specific options with default values

      # Format of message log option
      @options.log_msgs = Constants::DEFAULT_LOG_MSGS

      # Format of message log
      @opt_parser.on(
        "--log-msgs FORMAT",
        String,
        "format of message(s) log (none/body/dict, "+
        "default: #{Constants::DEFAULT_LOG_MSGS})"
      ) do |log_msgs|
        @options.log_msgs = log_msgs
      end
    end # initialize(args)

    # Parsing of basic and common options for sender and receiver client
    # ==== Parameters
    # args:: arguments to parse
    def parse(args)
      @opt_parser.parse(args)
    end # parse(args)

  end # class SRCommonOptionParser

end # module Options

# eof
