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
require_relative 'options/connector_option_parser'
require_relative 'handlers/connector_handler'

# ConnectorClient parses arguments
# and runs connector
class ConnectorClient

  # Initialization of connector client,
  # parsing connector client arguments
  # and connector client run
  # ==== Parameters
  # args:: connector client arguments
  def initialize(args)
    # Parse arguments
    connector_options_parser = Options::ConnectorOptionParser.new(args)
    # Create connector handler
    connector_handler = Handlers::ConnectorHandler.new(
      connector_options_parser.options.broker,
      connector_options_parser.options.count
    )
    # Run connector client
    Qpid::Proton::Container.new(connector_handler).run
  end # initialize(args)

end # class ConnectorClient

# eof
