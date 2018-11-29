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

require_relative '../utils/string_utils'

module Formatters

  # Basic formatter of message body
  class BasicFormatter

    # Message to format
    attr_accessor :message
    # Content hashed
    attr_accessor :msg_content_hashed

    # Initialization of basic formatter
    # ==== Basic formatter arguments
    # message:: message to format
    def initialize(message, msg_content_hashed=false)
      # Save message
      @message = message
      @msg_content_hashed = msg_content_hashed
    end # initialize(message)

    # Format value according to type
    # ==== Parameters
    # value:: value to format
    # ==== Returns
    # value formatted as string
    def format_value(value)
      # Switch by class of value
      case value
      # Boolean value
      when TrueClass, FalseClass
        value ? "True" : "False"
      # Numeric or Range value
      when Integer, Float, Numeric, Range #, Bignum, Fixnum are deprecated
        value
      # Array value
      when Array
        # Array for formatted items of array
        help_array = []
        # Each item in array needs to be formatted
        value.each do |item|
          # Format array item
          help_array.push(format_value(item))
        end
        "[#{help_array.join(", ")}]"
      # Dictionary/hash value
      when Hash
        # Array for formatted items of hash
        help_array = []
        # Each key-value pair needs to be formatted
        value.each do |key, val|
          # Format key-value pair of item
          help_array.push("#{format_value(key)}: #{format_value(val)}")
        end
        "{#{help_array.join(", ")}}"
      # String or symbol value
      when Symbol
        value.size > 0 ? "'#{value}'" : "None"
      when String
        value.size > 0 ? "'#{value.gsub(/'/, %q(\\\'))}'" : "None"
      # Nil value
      when NilClass
        "None"
      # Other or unknown type
      else
        raise TypeError, "Unknown value type"
      end # case
    end # format_value(value)

    # Prints formatted message body to stdout
    def print()
      # Print formatted body to stdout
      puts format_value(@msg_content_hashed ? StringUtils.sha1_hash(@message.body) : @message.body)
    end # print()

    # Escapes characters which Python's eval() cannot load
    # that is esp. \0, \r, \n. Use a range, to be safe.
    def self.escape_chars(msg_string)
      if msg_string.nil?
        nil
      else
        msg_string.each_codepoint.map do |s|
          if s < 32 || s > 126
            format('\\u%04x', s)
          else
            s.chr
          end
        end.join
      end
    end

  end # class BasicFormatter

end # module Formatters

# eof
