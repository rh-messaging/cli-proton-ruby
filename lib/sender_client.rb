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

require 'qpid_proton'
require_relative 'options/sender_option_parser'
require_relative 'handlers/sender_handler'

# SenderClient parses arguments
# and runs sender
class SenderClient

  # Initialization of sender client,
  # parsing sender client arguments
  # and sender client run
  # ==== Parameters
  # args:: sender client arguments
  def initialize(args)
    # Parse arguments
    sender_options_parser = Options::SenderOptionParser.new(args)
    # Create sender handler
    sender_handler = Handlers::SenderHandler.new(
      sender_options_parser.options.broker,
      sender_options_parser.options.address,
      sender_options_parser.options.log_msgs,
      sender_options_parser.options.count,
      sender_options_parser.options.msg_content
    )
    # Run sender client
    Qpid::Proton::Reactor::Container.new(sender_handler).run
  end # initialize(args)

end # class SenderClient

# eof
