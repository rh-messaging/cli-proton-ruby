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
require_relative 'patches/container' # TODO aconway 2018-04-04: remove monkey-patch
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
      sender_options_parser.options.log_msgs,
      sender_options_parser.options.count,
      sender_options_parser.options.msg_properties,
      sender_options_parser.options.msg_content,
      sender_options_parser.options.msg_content_type,
      sender_options_parser.options.msg_durable,
      sender_options_parser.options.msg_ttl,
      sender_options_parser.options.msg_correlation_id,
      sender_options_parser.options.msg_reply_to,
      sender_options_parser.options.msg_group_id,
      sender_options_parser.options.msg_priority,
      sender_options_parser.options.msg_id,
      sender_options_parser.options.msg_user_id,
      sender_options_parser.options.msg_subject,
      sender_options_parser.options.anonymous,
      sender_options_parser.options.sasl_mechs,
      sender_options_parser.options.idle_timeout,
      sender_options_parser.options.max_frame_size,
      sender_options_parser.options.log_lib,
      sender_options_parser.options.auto_settle_off,
      sender_options_parser.options.exit_timer,
      sender_options_parser.options.duration,
      sender_options_parser.options.duration_mode
    )
    # Run sender client
    Qpid::Proton::Container.new(sender_handler).run
  end

end # class SenderClient

# eof
