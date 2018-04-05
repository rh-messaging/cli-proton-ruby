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
#!/usr/bin/env ruby
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

require 'minitest/autorun'

require_relative '../../../lib/utils/duration'

class UnitTestsDuration < Minitest::Test

  def test_duration_total_time
    start = Time.now
    d = Duration.new(0.1, 10, "")
    10.times do
      sleep(rand()*0.01)       # Mess with the time, d.delay should compensate
      sleep(d.delay(""))
    end
    assert_in_delta(start + 0.1, Time.now, 0.01)
  end

  def test_duration_wrong_mode
    start = Time.now
    d = Duration.new(0.1, 10, "")
    10.times { d.delay("x") }
    assert_in_delta(start, Time.now, 0.01)
  end
end # class UnitTestsStringUtils

# eof
