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

require 'options/basic_option_parser'
require 'options/connector_option_parser'
require 'options/sr_common_option_parser'
require 'options/sender_option_parser'
require 'options/receiver_option_parser'

# Module containing option parsers for cli-proton-ruby clients
# ==== Option parsers
# * Options::BasicOptionParser of basic options for all clients
# * Options::ConnectorOptionParser of basic and specific options for connector
#   client
# * Options::SRCommonOptionParser of basic and common options for sender and
#   receiver client
# * Options::SenderOptionParser of basic, common and specific options
#   for sender client
# * Options::ReceiverOptionParser of basic, common and specific options
#   for receiver client
module Options
end

# eof
