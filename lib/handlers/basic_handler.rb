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

require 'qpid_proton'

module Handlers

  # Basic events handler for all clients
  class BasicHandler < Qpid::Proton::MessagingHandler

    # URL of broker
    attr_accessor :broker

    # Initialization of basic events handler for all clients
    # ==== Basic events handler arguments
    # broker:: URL of broker
    def initialize(broker)
      super()
      # Save URL of broker
      if broker.is_a? Qpid::Proton::URL
        @broker = broker
      else
        @broker = Qpid::Proton::URL.new(broker)
      end
    end # initialize(broker)

  end # class BasicHandler

end # module Handlers

# eof
