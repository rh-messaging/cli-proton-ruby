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

# Module containing constants and default values
module Constants

  # Default value for broker URL in format IP:PORT
  DEFAULT_BROKER      = "127.0.0.1:5672"
  # Default value for message(s)/connection(s) count to send/receive/create
  DEFAULT_COUNT       = 1
  # Default value for name of queue/topic
  DEFAULT_ADDRESS     = "examples"
  # Default value for format of message(s) log
  DEFAULT_LOG_MSGS    = "none"
  # Default value for message content
  DEFAULT_MSG_CONTENT = nil

end # module Constants

# eof
