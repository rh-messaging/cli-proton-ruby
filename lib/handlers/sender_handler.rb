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

  # Sender events handler for sender client
  class SenderHandler < Handlers::SRCommonHandler

    # Count of messages to be send
    attr_accessor :count
    # Message properties
    attr_accessor :msg_properties
    # Message content
    attr_accessor :msg_content
    # Message content type
    attr_accessor :msg_content_type
    # Message durability
    attr_accessor :msg_durable
    # Message TTL (ms)
    attr_accessor :msg_ttl
    # Message correlation ID
    attr_accessor :msg_correlation_id
    # Reply to address
    attr_accessor :msg_reply_to
    # Message group ID
    attr_accessor :msg_group_id
    # Message priority
    attr_accessor :msg_priority
    # Message ID
    attr_accessor :msg_id
    # Message user ID
    attr_accessor :msg_user_id
    # Message subject
    attr_accessor :msg_subject
    # Anonymous
    attr_accessor :anonymous

    # Initialization of sender events handler
    # ==== Sender events handler arguments
    # broker:: URI of broker
    # log_msgs:: format of message(s) log
    # count:: number of messages to send
    # msg_content:: message content
    # msg_durable:: message durability
    # msg_ttl:: message TTL (ms)
    # msg_correlation_id:: message correlation ID
    # msg_reply_to:: address to send reply to
    # msg_group_id:: message group ID
    # sasl_mechs:: allowed SASL mechanisms
    def initialize(
      broker,
      log_msgs,
      count,
      msg_properties,
      msg_content,
      msg_content_type,
      msg_durable,
      msg_ttl,
      msg_correlation_id,
      msg_reply_to,
      msg_group_id,
      msg_priority,
      msg_id,
      msg_user_id,
      msg_subject,
      anonymous,
      sasl_mechs,
      idle_timeout,
      exit_timer
    )
      super(broker, log_msgs, sasl_mechs, idle_timeout, exit_timer)
      # Save count of messages to be send
      @count = count
      # Save message properties
      @msg_properties = msg_properties
      # Save message content
      @msg_content = msg_content
      # Save message content type
      @msg_content_type = msg_content_type
      # Save message durability
      @msg_durable = msg_durable
      # Save message TTL (ms)
      @msg_ttl = msg_ttl
      # Save message correlation ID
      @msg_correlation_id = msg_correlation_id
      # Save reply to address
      @msg_reply_to = msg_reply_to
      # Save message group ID
      @msg_group_id = msg_group_id
      # Save message priority
      @msg_priority = msg_priority
      # Save message ID
      @msg_id = msg_id
      # Save user ID
      @msg_user_id = msg_user_id
      # Save message subject
      @msg_subject = msg_subject
      # Save anonymous
      @anonymous = anonymous
      # Number of sent messages
      @sent = 0
      # Number of accepted messages
      @accepted = 0
    end

    # Called when the event loop starts,
    # connects sender client to SRCommonHandler#broker
    # and creates sender
    def on_container_start(container)
      # Connecting to broker and creating sender
      container.connect(
        # Set broker URI
        @broker,
        # Enable SASL authentication
        sasl_enabled: true,
        # Enable insecure SASL mechanisms
        sasl_allow_insecure_mechs: true,
        # Set allowed SASL mechanisms
        sasl_allowed_mechs: @sasl_mechs,
        # Set idle timeout
        idle_timeout: @idle_timeout,
      ).open_sender(anonymous ? nil : @broker.amqp_address)
    end

    # Called when the sender link has credit
    # and messages can therefore be transferred,
    # sending SenderHandler#count messages
    def on_sendable(sender)
      # While sender credit is available
      # and number of sent messages is less than count
      while (sender.credit > 0) && (@sent < @count)
        exit_timer.reset if exit_timer
        # Create new message
        msg = Qpid::Proton::Message.new
        msg.address = @broker.amqp_address if @anonymous
        # Set message properties
        if @msg_properties
          @msg_properties.each { |k, v| msg[k] = v }
        end
        # If message content is set
        if @msg_content
          # If message content is string and contains formatting part
          if @msg_content.is_a? String and @msg_content =~ /%[0-9]*d/
            # Format message content with number of sent messages
            msg.body = sprintf(@msg_content, @sent)
          else
            # Set message content as it is
            msg.body = @msg_content
          end
        end # if
        # Set message content type if specified
        msg.content_type = @msg_content_type if @msg_content_type
        # Set message durability
        msg.durable = @msg_durable
        # Set message TTL (ms)
        msg.ttl = @msg_ttl
        # If message correlation ID is set
        if @msg_correlation_id
          msg.correlation_id = @msg_correlation_id
        end # if
        # Set reply to address
        msg.reply_to = @msg_reply_to
        # If message group ID is set
        if @msg_group_id
          msg.group_id = @msg_group_id
        end
        msg.priority = @msg_priority if @msg_priority
        msg.id = @msg_id if @msg_id
        msg.user_id = @msg_user_id if @msg_user_id
        msg.subject = @msg_subject if @msg_subject
        # Send message
        sender.send(msg)
        # Increase number of sent messages
        @sent = @sent + 1
        if @log_msgs == "body"
          Formatters::BasicFormatter.new(msg).print
        elsif @log_msgs == "dict"
          Formatters::DictFormatter.new(msg).print
        end
      end # while
    end

    # Called when the remote peer accepts an outgoing message,
    # accepting SenderHandler#count messages
    def on_tracker_accept(tracker)
      # Increase number of accepted messages
      @accepted = @accepted + 1
      # If all messages to be send are sent and accepted
      if @accepted == @count
        # Close sender
        tracker.sender.close
        # Close connection
        tracker.sender.connection.close
      end # if
    end

  end # class SenderHandler

end # module Handlers

# eof
