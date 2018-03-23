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

# Module containing environment utilities for cli-proton-ruby clients
module EnvUtils

  # Function to set environment variable for client library logging
  # ==== Parameters
  # level:: log level to set and use
  def self.set_log_lib_env(level)
    case level
    when "TRANSPORT_FRM"
      ENV['PN_TRACE_FRM'] = "true"
    when "TRANSPORT_RAW"
      ENV['PN_TRACE_RAW'] = "true"
    when "TRANSPORT_DRV"
      ENV['PN_TRACE_DRV'] = "true"
    when "NONE"
    else
      raise ArgumentError, "Invalid client library logging level: #{level}"
    end
  end

end # module EnvUtils

# eof
