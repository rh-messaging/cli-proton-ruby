#--
# Copyright 2018 Red Hat Inc.
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

require_relative 'dict_formatter'

module Formatters

  # Formatter of message into dictionary format
  class InteropFormatter < Formatters::DictFormatter

    # Initialization of dictionary formatter
    # ==== Dictionary formatter arguments
    # message:: message to format
    def initialize(message)
      super(message)
    end # initialize(message)

    # Format value according to type
    # ==== Parameters
    # value:: value to format
    # ==== Returns
    # value formatted as string
    def format_value(value)
      case value
      when Float
        # ab_diff = [{'content': [[-1.3, -1.2999999523162842]]}]
        value.round(5)
      else
        super
      end
    end

  end # class DictFormatter

end # module Formatters