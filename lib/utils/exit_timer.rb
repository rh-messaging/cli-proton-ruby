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

# Timer that exits the process if it expires.
# Use a timer thread, as the Qpid::Proton::Container does not yet provide scheduled tasks.

class ExitTimer

  attr_reader :timeout

  # Start the timer to exit after timeout.
  def initialize(timeout)
    @timeout = timeout
    @lock = Mutex.new
    reset
    Thread.new do
      while (delta = @lock.synchronize { @deadline - Time.now } ) > 0
        sleep delta
      end
      puts "timeout expired"
      exit(0)
    end
  end

  # Reset the timer to count to timeout from now
  def reset()
    @lock.synchronize { @deadline = Time.now + @timeout }
  end

end
