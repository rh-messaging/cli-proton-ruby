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

require_relative 'sr_common_handler'

module Handlers

  # Sender events handler for sender client
  class SenderHandler < Handlers::SRCommonHandler

    # Count of messages
    attr_accessor :count
    # Message content
    attr_accessor :msg_content

    # Initialization of sender events handler
    # ==== Sender events handler arguments
    # broker:: URL of broker in format IP:PORT
    # address:: name of queue/topic
    # log_msgs:: format of message(s) log
    # count:: number of messages to send
    # msg_content:: message content
    def initialize(broker, address, log_msgs, count, msg_content)
      super(broker, address, log_msgs)
      # Save count of messages
      @count = count
      # Save message content
      @msg_content = msg_content
      # Number of sent messages
      @sent = 0
      # Number of accepted messages
      @accepted = 0
    end # initialize(broker, address, log_msgs, count, msg_content)

    # Called when the event loop starts,
    # connects sender client to SRCommonHandler#broker
    # and creates sender connected to SRCommonHandler#address
    def on_start(event)
      # Connecting to broker and creating sender
      @connection = event.container.create_sender([@broker, @address].join("/"))
    end # on_start(event)

    # Called when the sender link has credit
    # and messages can therefore be transferred,
    # sending SenderHandler#count messages
    def on_sendable(event)
      # While sender credit is available
      # and number of sent messages is less than count
      while (event.sender.credit > 0) && (@sent < @count)
        # Create new message
        msg = Qpid::Proton::Message.new
        # If message content is set
        if @msg_content
          # Set message content
          msg.body = msg_content
        end # if
        # Send message
        event.sender.send(msg)
        # Increase number of sent messages
        @sent = @sent + 1
        puts "Sent message with body: '#{@msg_content}'"
      end # while
    end # on_sendable(event)

    # Called when the remote peer accepts an outgoing message,
    # accepting SenderHandler#count messages
    def on_accepted(event)
      # Increase number of accepted messages
      @accepted = @accepted + 1
      # If all messages are accepted
      if @accepted == @count
        # Close connection
        event.connection.close
      end # if
    end # on_accepted(event)

  end # class SenderHandler

end # module Handlers

# eof
