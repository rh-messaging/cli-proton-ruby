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

require 'sender_client'
require 'receiver_client'

BIN_DIR = File.absolute_path("../../bin", File.dirname(__FILE__))

class TestClients < Minitest::Test

  def run_client(prog, *args)
    prog = File.join(BIN_DIR, prog)
    return IO.popen([ RbConfig.ruby, prog ] + args.map { |a| a.to_s },
                   :err=>[:child, :out]) # Include stderr in output
  end

  def assert_wait(proc, status=0)
    Process.wait(proc.pid)
    assert_equal status, $?.exitstatus
  end

  def assert_output(proc, output, status=0)
    assert_equal output, proc.read
    assert_wait proc, status
  end

  def test_send_receive
    r = run_client("cli-proton-ruby-receiver", "--log-msgs=body")
    s = run_client("cli-proton-ruby-sender", "--msg-content=hello")
    assert_output s, ""
    assert_output r, "'hello'\n"
  end

end
