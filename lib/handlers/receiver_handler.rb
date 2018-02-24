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
    # Browse
    attr_accessor :browse

    # Initialization of receiver events handler
    # ==== Receiver events handler arguments
    # broker:: URI of broker
    # log_msgs:: format of message(s) log
    # count:: number of messages to receive
    # browse:: browse messages instead of reading
    def initialize(broker, log_msgs, count, browse)
      super(broker, log_msgs)
      # Save count of messages
      @count = count
      # Save browse
      @browse = browse
      # Number of received messages
      @received = 0
    end # initialize(broker, log_msgs, count, browse)

    # Called when the event loop starts,
    # connects receiver client to SRCommonHandler#broker
    # and creates receiver
    def on_container_start(container)
      # Set SASL mechanisms to default value
      sasl_mechs = Defaults::DEFAULT_SASL_MECHS
      # If user and password are set
      if @broker.user and @broker.password
        # Set SASL mechanisms to PLAIN
        sasl_mechs = "PLAIN"
      end
      # Connecting to broker
      @connection = container.connect(
        @broker,
        sasl_enabled: true,
        sasl_allow_insecure_mechs: true,
        sasl_allowed_mechs: sasl_mechs
      )
      # Creating receiver
      @receiver = @connection.open_receiver(@broker.amqp_address)
      # If browse messages instead of reading
      if browse
        # Set browsing mode
        @receiver.source.distribution_mode = Qpid::Proton::Terminus::DIST_MODE_COPY
      end
    end # on_start(event)

    # Called when a message is received,
    # receiving ReceiverHandler#count messages
    def on_message(delivery, message)
      # Print received message
      if @log_msgs == "body"
        Formatters::BasicFormatter.new(message).print
      elsif @log_msgs == "dict"
        Formatters::DictFormatter.new(message).print
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
    end # on_message(event)

  end # class ReceiverHandler

end # module Handlers

# eof
