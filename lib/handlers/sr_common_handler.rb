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

require_relative 'basic_handler'

require_relative '../formatters/basic_formatter'
require_relative '../formatters/dict_formatter'
require_relative '../formatters/interop_formatter'

module Handlers

  # Common events handler for sender and receiver client
  class SRCommonHandler < Handlers::BasicHandler

    # Format of log
    attr_accessor :log_msgs
    # Content hashed
    attr_accessor :msg_content_hashed
    # Idle timeout
    attr_accessor :idle_timeout
    # Max frame size
    attr_accessor :max_frame_size
    # SASL enabled
    attr_accessor :sasl_enabled
    # Client library logging
    attr_accessor :log_lib
    # Auto settle off
    attr_accessor :auto_settle_off

    # Initialization of common events handler for sender and receiver client
    # ==== Common events handler arguments
    # broker:: URI of broker
    # log_msgs:: format of message(s) log
    # sasl_mechs:: allowed SASL mechanisms
    def initialize(
      broker,
      log_msgs,
      msg_content_hashed,
      sasl_mechs,
      idle_timeout,
      max_frame_size,
      sasl_enabled,
      log_lib,
      auto_settle_off,
      exit_timer
    )
      super(
        broker,
        sasl_mechs,
        idle_timeout,
        max_frame_size,
        sasl_enabled,
        log_lib,
        exit_timer
      )
      # Save message(s) log format
      @log_msgs = log_msgs
      # Save message(s) content hashed
      @msg_content_hashed = msg_content_hashed
      # Save auto settle off
      @auto_settle_off = auto_settle_off
    end

    # Print of sent/received message
    # ==== Arguments
    # msg:: message to print
    def print_message(msg)
      case @log_msgs
      when "body"
        Formatters::BasicFormatter.new(msg, @msg_content_hashed).print
      when "dict"
        Formatters::DictFormatter.new(msg, @msg_content_hashed).print
      when "interop"
        Formatters::InteropFormatter.new(msg, @msg_content_hashed).print
      end
    end

    # Default for un-handled errors is to raise an exception
    def on_error(condition)
      raise condition
    end

  end # class SRCommonHandler

end # module Handlers

# eof
