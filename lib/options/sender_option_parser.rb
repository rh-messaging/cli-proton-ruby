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
  # and specific options for sender client
  # ==== Specific sender options
  # count:: number of messages to send (default: DEFAULT_COUNT, see Constants)
  # msg-content:: message content (default: DEFAULT_MSG_CONTENT,
  #               see Constants)
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
      @options.count = Constants::DEFAULT_COUNT
      # Message content option
      @options.msg_content = Constants::DEFAULT_MSG_CONTENT

      # Number of messages
      @opt_parser.on(
        "-c",
        "--count COUNT",
        Integer,
        "number of messages to send (default: #{Constants::DEFAULT_COUNT})"
      ) do |count|
        @options.count = count
      end

      # Message content
      @opt_parser.on(
        "-m",
        "--msg-content CONTENT",
        String,
        "message content (default: "+(
          if Constants::DEFAULT_MSG_CONTENT.nil? then
            "nil"
          else
            Constants::DEFAULT_MSG_CONTENT
          end
        )+")"
      ) do |msg_content|
        @options.msg_content = msg_content
      end

      # Parse basic, common and specific options for sender client
      parse(args)
    end # initialize(args)

  end # class SenderOptionParser

end # module Options

# eof
