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

# Module containing utilities for cli-proton-ruby clients
module Utils

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

end # module Utils

# eof
