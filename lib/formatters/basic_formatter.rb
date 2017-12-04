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

module Formatters

  # Basic formatter of message body
  class BasicFormatter

    # Message to format
    attr_accessor :message

    # Initialization of basic formatter
    # ==== Basic formatter arguments
    # message:: message to format
    def initialize(message)
      # Save message
      @message = message
    end # initialize(message)

    # Format value according to type
    # ==== Parameters
    # value:: value to format
    # ==== Returns
    # value formatted as string
    def formatValue(value)
      # Switch by class of value
      case value
      # Boolean value
      when TrueClass, FalseClass
        return value ? "True" : "False"
      # Numeric or Range value
      when Integer, Float, Numeric, Range #, Bignum, Fixnum are deprecated
        return value
      # Array value
      when Array
        # Array for formatted items of array
        helpArray = []
        # Each item in array needs to be formatted
        value.each do |item|
          # Format array item
          helpArray.push(formatValue(item))
        end
        return "[#{helpArray.join(", ")}]"
      # Dictionary/hash value
      when Hash
        # Array for formatted items of hash
        helpArray = []
        # Each key-value pair needs to be formatted
        value.each do |key, value|
          # Format key-value pair of item
          helpArray.push("#{formatValue(key)}: #{formatValue(value)}")
        end
        return "{#{helpArray.join(", ")}}"
      # String or symbol value
      when String, Symbol
        return "\"#{value}\""
      # Nil value
      when NilClass
        return "None"
      # Other or unknown type
      else
        raise TypeError, "Unknown value type"
      end # case
    end # formatValue(value)

    # Prints formatted message body
    def print()
      # Print formatted body
      puts formatValue(@message.body)
    end # print()

  end # class BasicFormatter

end # module Formatters

# eof
