# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

require 'qpid_proton'

# Monkey-patch to fix https://issues.apache.org/jira/browse/PROTON-1820 in proton 0.22
# The patch will not be needed with proton >= 0.23
module Qpid::Proton

  module ContainerFix
    def run_one(task, now)
      if task == :schedule
        @lock.synchronize { @active -= 1; check_stop_lh } if maybe_panic { @schedule.process now }
        @lock.synchronize { @schedule_working = false }
        wake
      else
        super
      end
    end
  end

  class Container
    prepend ContainerFix
  end
end
