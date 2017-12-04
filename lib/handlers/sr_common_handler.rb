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

    # Name of queue/topic
    attr_accessor :address
    # Format of log
    attr_accessor :log_msgs

    # Initialization of common events handler for sender and receiver client
    # ==== Common events handler arguments
    # broker:: URL of broker in format IP:PORT
    # address:: name of queue/topic
    # log_msgs:: format of message(s) log
    def initialize(broker, address, log_msgs)
      super(broker)
      # Save address
      @address = address
      # Save message(s) log format
      @log_msgs = log_msgs
    end # initialize(broker, address, log_msgs)

  end # class SRCommonHandler

end # module Handlers

# eof
