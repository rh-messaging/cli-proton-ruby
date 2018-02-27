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

require_relative '../formatters/basic_formatter'
require_relative '../formatters/dict_formatter'
require_relative 'sr_common_handler'

module Handlers

  # Receiver events handler for receiver client
  class ReceiverHandler < Handlers::SRCommonHandler

    # Count of messages
    attr_accessor :count
    # Process reply to
    attr_accessor :process_reply_to
    # Browse
    attr_accessor :browse

    # Initialization of receiver events handler
    # ==== Receiver events handler arguments
    # broker:: URI of broker
    # log_msgs:: format of message(s) log
    # count:: number of messages to receive
    # process-reply-to:: send message to reply-to address if enabled
    #                    and message got reply-to address
    # browse:: browse messages instead of reading
    # sasl_mechs:: allowed SASL mechanisms
    def initialize(
      broker,
      log_msgs,
      count,
      process_reply_to,
      browse,
      sasl_mechs
    )
      super(broker, log_msgs, sasl_mechs)
      # Save count of messages
      @count = count
      # Save process reply to
      @process_reply_to = process_reply_to
      # Save browse
      @browse = browse
      # Number of received messages
      @received = 0
      # Hash with senders for replying
      @senders = {}
    end

    # Called when the event loop starts,
    # connects receiver client to SRCommonHandler#broker
    # and creates receiver
    def on_container_start(container)
      # Connecting to broker and creating receiver
      @receiver = container.connect(
        # Set broker URI
        @broker,
        # Enabled SASL authentication
        sasl_enabled: true,
        # Enabled insecure SASL mechanisms
        sasl_allow_insecure_mechs: true,
        # Set allowed SASL mechanisms
        sasl_allowed_mechs: @sasl_mechs
      ).open_receiver(@broker.amqp_address)
      # If browse messages instead of reading
      if browse
        # Set browsing mode
        @receiver.source.distribution_mode = \
          Qpid::Proton::Terminus::DIST_MODE_COPY
      end
    end

    # Called when a message is received,
    # receiving ReceiverHandler#count messages
    def on_message(delivery, message)
      # Print received message
      if @log_msgs == "body"
        Formatters::BasicFormatter.new(message).print
      elsif @log_msgs == "dict"
        Formatters::DictFormatter.new(message).print
      end
      # If process reply to
      if @process_reply_to and !message.reply_to.nil?
        self.do_process_reply_to(message)
      end
      # Increase number of received messages
      @received = @received + 1
      # If all messages are received
      if @received == @count
        # Close receiver
        delivery.receiver.close
        # Close connection
        delivery.receiver.connection.close
      end # if
    end

    def do_process_reply_to(message)
      if !@senders.include?(message.reply_to)
        @senders[message.reply_to] = @receiver.connection.open_sender(
          message.reply_to
        )
      end
      message.address = message.reply_to
      @senders[message.reply_to].send(message)
    end

  end # class ReceiverHandler

end # module Handlers

# eof
