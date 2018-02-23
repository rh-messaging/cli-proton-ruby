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

  # Connector events handler for connector client
  class ConnectorHandler < Handlers::BasicHandler

    # Count of connections
    attr_accessor :count
    # Array of connections
    attr_accessor :connections

    # Initialization of events handler for connector client
    # ==== Connector events handler arguments
    # broker:: URI of broker
    # count:: Number of connections to create
    def initialize(broker, count)
      super(broker)
      # Save count of connections
      @count = count
      # Initialize array of connections
      @connections = []
    end # initialize(broker, count)

    # Called when the event loop starts,
    # connecting ConnectorHandler#count number of connections
    def on_container_start(container)
      # Set SASL mechanisms to default value
      sasl_mechs = Constants::DEFAULT_SASL_MECHS
      # If user and password are set
      if @broker.user and @broker.password
        # Set SASL mechanisms to PLAIN
        sasl_mechs = "PLAIN"
      end
      # Connecting count number of connections
      @count.times do
        # Save created connection(s) into array
        @connections.push(container.connect(
          @broker,
          sasl_enabled: true,
          sasl_allow_insecure_mechs: true,
          sasl_allowed_mechs: sasl_mechs
        ))
      end
    end

  end # class ConnectorHandler

end # module Handlers

# eof
