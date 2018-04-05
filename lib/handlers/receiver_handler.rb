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
require_relative '../utils/duration'
require_relative 'sr_common_handler'

module Handlers

  # Receiver events handler for receiver client
  class ReceiverHandler < Handlers::SRCommonHandler

    # Count of expected messages to be received
    attr_accessor :count
    # Process reply to
    attr_accessor :process_reply_to
    # Browse
    attr_accessor :browse
    # Selector
    attr_accessor :selector
    # Receiver listen
    attr_accessor :recv_listen
    # Receiver listen port
    attr_accessor :recv_listen_port

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
      selector,
      sasl_mechs,
      idle_timeout,
      max_frame_size,
      log_lib,
      recv_listen,
      recv_listen_port,
      auto_settle_off,
      exit_timer,
      duration,
      duration_mode
    )
      super(
        broker,
        log_msgs,
        sasl_mechs,
        idle_timeout,
        max_frame_size,
        log_lib,
        auto_settle_off,
        exit_timer
      )
      # Save count of expected messages to be received
      @count = count
      # Save process reply to
      @process_reply_to = process_reply_to
      # Save browse
      @browse = browse
      # Save selector
      @selector = selector
      # Save recv-listen value
      @recv_listen = recv_listen
      # Save recv-listen port value
      @recv_listen_port = recv_listen_port
      # Number of received messages
      @received = 0
      # Flag indicating that all expected messages were received
      @all_received = false
      # Hash with senders for replying
      @senders = {}
      # Counter of sent messages when processing reply-to
      @sent = 0
      # Counter of accepted messages
      @accepted = 0
      # Duration
      @duration = Duration.new(duration, count, duration_mode);
    end

    # Called when the event loop starts,
    # connects receiver client to SRCommonHandler#broker
    # and creates receiver
    def on_container_start(container)
      if @recv_listen # P2P
        @listener = container.listen("0.0.0.0:#{@recv_listen_port}")
      else # Broker
        # Prepare source options
        source = {}
        source[:address] = @broker.amqp_address
        source[:filter] = { :selector => make_apache_selector(@selector)} if @selector
        # Connecting to broker and creating receiver
        @receiver = container.connect(
          # Set broker URI
          @broker,
          # Enabled SASL authentication
          sasl_enabled: true,
          # Enabled insecure SASL mechanisms
          sasl_allow_insecure_mechs: true,
          # Set allowed SASL mechanisms
          sasl_allowed_mechs: @sasl_mechs,
          # Set idle timeout
          idle_timeout: @idle_timeout,
          # Set max frame size
          max_frame_size: @max_frame_size,
        ).open_receiver(:source => source)
        # If browse messages instead of reading
        if browse
          # Set browsing mode
          @receiver.source.distribution_mode = \
            Qpid::Proton::Terminus::DIST_MODE_COPY
        end
      end
    end

    # Called when a message is received,
    # receiving ReceiverHandler#count messages
    def on_message(delivery, message)
      @duration.delay("before-receive") { |d| sleep d }
      exit_timer.reset if exit_timer
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
      # If expected count of messages to be received is not zero
      # and all expected messages are received
      if @count > 0 and @received == @count
        # Set flag indicating that all expected messages were received to true
        @all_received = true
        # Close listener when listening
        if recv_listen
          # Close listener if not processing reply-to
          @listener.close unless process_reply_to
        # Close receiver when not listening, but receiving
        else
          # Close receiver
          delivery.receiver.close 
          # Close connection if not processing reply-to
          delivery.receiver.connection.close unless process_reply_to
        end
      end # if
      @duration.delay("after-receive") { |d| sleep d }
    end

    # Processing reply to reply-to address of message
    def do_process_reply_to(message)
      # If sender for actual reply-to address does not exist
      unless @senders.include?(message.reply_to)
        # Create new sender for reply-to address
        @senders[message.reply_to] = @receiver.connection.open_sender({
          # Set target address
          :target => message.reply_to,
          # Set auto settle
          :auto_settle => @auto_settle_off ? false : true,
        })
      end
      # Set target address of message to be send to reply-to address
      message.address = message.reply_to
      # Increase number of sent messages
      @sent = @sent + 1
      # Send message to reply-to address
      @senders[message.reply_to].send(message)
    end

    # Called when the remote peer accepts an outgoing message,
    # accepting ReceiverHandler#sent messages
    def on_tracker_accept(_tracker)
      # Increase number of accepted messages
      @accepted = @accepted + 1
      # If all expected messages were received
      # and all sent messages were accepted
      if @all_received and @accepted == @sent
        # Close all senders and their connections
        @senders.each do |_, i_sender|
          # Close sender
          i_sender.close
          # Close connection of sender
          i_sender.connection.close
        end
      end # if
    end

    private
    def make_apache_selector(selector)
      Qpid::Proton::Types::Described.new(:"apache.org:selector-filter:string", selector)
    end

  end # class ReceiverHandler

end # module Handlers

# eof
