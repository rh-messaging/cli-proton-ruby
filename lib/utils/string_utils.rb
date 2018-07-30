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

require 'digest'

# Module containing string utilities for cli-proton-ruby clients
module StringUtils

  # Function to check if string variable is convertible to integer
  # ==== Parameters
  # value:: string variable to convert
  # ==== Returns
  # true if string variable is convertible to integer, false otherwise
  def self.str_is_int?(value)
    !Integer(value).nil? rescue false
  end

  # Function to check if string variable is convertible to float
  # ==== Parameters
  # value:: string variable to convert
  # ==== Returns
  # true if string variable is convertible to float, false otherwise
  def self.str_is_float?(value)
    !Float(value).nil? rescue false
  end

  # Function to check if string variable is convertible to client bool value
  # ==== Returns
  # true if string variable is convertible to client bool value, false otherwise
  def self.str_is_bool?(value)
    begin
      str_to_bool value
    rescue ArgumentError
      return false
    end

    return true
  end

  # Function to convert string variable to client bool value
  # (yes/no|True/False|true/false)
  # ==== Parameters
  # value:: string variable to convert
  # ==== Returns
  # bool value of the variable
  # ==== Raises
  # ArgumentError for invalid argument
  def self.str_to_bool(value)
    # If positive value
    if ["yes", "True", "true"].include?(value)
      # Return true
      return true
    # If negative value
    elsif ["no", "False", "false"].include?(value)
      # Return false
      return false
    end
    # If value is not convertible, raise ArgumentError
    raise ArgumentError, "invalid value for Boolean(): \"#{value}\""
  end

  def self.sha1_hash(value)
    Digest::SHA1.hexdigest value.to_s
  end

end # module StringUtils

# eof
