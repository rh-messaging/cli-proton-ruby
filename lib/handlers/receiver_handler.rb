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

    # Initialization of receiver events handler
    # ==== Receiver events handler arguments
    # broker:: URL of broker in format IP:PORT
    # address:: name of queue/topic
    # log_msgs:: format of message(s) log
    # count:: number of messages to receive
    def initialize(broker, address, log_msgs, count)
      super(broker, address, log_msgs)
      # Save count of messages
      @count = count
      # Number of received messages
      @received = 0
    end # initialize(broker, address, log_msgs, count)

    # Called when the event loop starts,
    # connects receiver client to SRCommonHandler#broker
    # and creates receiver connected to SRCommonHandler#address
    def on_start(event)
      # Connecting to broker and creating receiver
      @connection = event.container.create_receiver(
        [@broker, @address].join("/")
      )
    end # on_start(event)

    # Called when a message is received,
    # receiving ReceiverHandler#count messages
    def on_message(event)
      # Print received message
      if @log_msgs == "body"
        Formatters::BasicFormatter.new(event.message).print
      elsif @log_msgs == "dict"
        Formatters::DictFormatter.new(event.message).print
      end
      # Increase number of received messages
      @received = @received + 1
      # If all messages are received
      if @received == @count
        # Close receiver
        event.receiver.close
        # Close connection
        event.connection.close
      end # if
    end # on_message(event)

  end # class ReceiverHandler

end # module Handlers

# eof
