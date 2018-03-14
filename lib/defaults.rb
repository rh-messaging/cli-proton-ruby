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

# Module containing default values
module Defaults

  # Default value for broker URI in format IP:PORT/queue
  DEFAULT_BROKER           = "127.0.0.1:5672/examples"
  # Default value for message(s)/connection(s) count to send/receive/create
  DEFAULT_COUNT            = 1
  # Default value for format of message(s) log
  DEFAULT_LOG_MSGS         = "none"
  # Default value of message properties
  DEFAULT_MSG_PROPERTIES   = {}
  # Default value for message content
  DEFAULT_MSG_CONTENT      = nil
  # Default value for message content type
  DEFAULT_MSG_CONTENT_TYPE = nil
  # Default message durability
  DEFAULT_MSG_DURABLE      = false
  # Default value for message correlation ID
  DEFAULT_CORR_ID          = nil
  # Default value for reply-to
  DEFAULT_MSG_REPLY_TO     = nil
  # Default value for process reply to
  DEFAULT_PROC_REPLY_TO    = false
  # Default value for message group ID
  DEFAULT_GROUP_ID         = nil
  # Default value for browse messages
  DEFAULT_BROWSE           = false
  # Default value for SASL allowed mechanisms
  DEFAULT_SASL_MECHS       = "ANONYMOUS PLAIN EXTERNAL"
  # Default value for idle timeout
  DEFAULT_IDLE_TIMEOUT     = 0
  # Default value for message TTL (ms)
  DEFAULT_MSG_TTL          = 0
  # Default value for message priority
  DEFAULT_MSG_PRIORITY     = nil
  # Default value for message ID
  DEFAULT_MSG_ID           = nil
  # Default value for message user ID
  DEFAULT_MSG_USER_ID      = nil
  # Default value for message subject
  DEFAULT_MSG_SUBJECT      = nil
  # Default value for exit timer
  DEFAULT_EXIT_TIMER       = nil

end # module Defaults

# eof
