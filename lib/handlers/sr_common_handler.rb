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

module Handlers

  # Common events handler for sender and receiver client
  class SRCommonHandler < Handlers::BasicHandler

    # Format of log
    attr_accessor :log_msgs

    # Initialization of common events handler for sender and receiver client
    # ==== Common events handler arguments
    # broker:: URI of broker
    # log_msgs:: format of message(s) log
    # sasl_mechs:: allowed SASL mechanisms
    def initialize(broker, log_msgs, sasl_mechs, exit_timer=nil)
      super(broker, sasl_mechs, exit_timer)
      # Save message(s) log format
      @log_msgs = log_msgs
    end

    # Default for un-handled errors is to raise an exception
    def on_error(condition)
      raise condition
    end

  end # class SRCommonHandler

end # module Handlers

# eof
