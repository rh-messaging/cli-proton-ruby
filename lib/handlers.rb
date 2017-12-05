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

require 'handlers/basic_handler'
require 'handlers/connector_handler'
require 'handlers/sr_common_handler'
require 'handlers/sender_handler'
require 'handlers/receiver_handler'

# Module containing event handlers for cli-proton-ruby clients
# ==== Handlers
# * Handlers::BasicHandler for all clients
# * Handlers::ConnectorHandler for connector client
# * Handlers::SRCommonHandler for sender and receiver client
# * Handlers::SenderHandler for sender client
# * Handlers::ReceiverHandler for receiver client
module Handlers

end # module Handlers

# eof
