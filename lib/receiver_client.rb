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
require_relative 'options/receiver_option_parser'
require_relative 'handlers/receiver_handler'

# ReceiverClient parses arguments
# and runs receiver
class ReceiverClient

  # Initialization of receiver client,
  # parsing receiver client arguments
  # and receiver client run
  # ==== Parameters
  # args:: receiver client arguments
  def initialize(args)
    # Parse arguments
    receiver_options_parser = Options::ReceiverOptionParser.new(args)
    # Create receiver handler
    receiver_handler = Handlers::ReceiverHandler.new(
      receiver_options_parser.options.broker,
      receiver_options_parser.options.log_msgs,
      receiver_options_parser.options.count,
      receiver_options_parser.options.prefetch,
      receiver_options_parser.options.process_reply_to,
      receiver_options_parser.options.browse,
      receiver_options_parser.options.selector,
      receiver_options_parser.options.sasl_mechs,
      receiver_options_parser.options.idle_timeout,
      receiver_options_parser.options.max_frame_size,
      receiver_options_parser.options.log_lib,
      receiver_options_parser.options.recv_listen,
      receiver_options_parser.options.recv_listen_port,
      receiver_options_parser.options.auto_settle_off,
      receiver_options_parser.options.exit_timer,
      receiver_options_parser.options.duration,
      receiver_options_parser.options.duration_mode
    )
    # Run receiver client
    Qpid::Proton::Container.new(receiver_handler).run
  end

end # class ReceiverClient

# eof
