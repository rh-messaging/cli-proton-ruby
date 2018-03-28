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
require 'benchmark'
require 'socket'

require 'sender_client'
require 'receiver_client'
require 'connector_client'

BIN_DIR = File.absolute_path("../../bin", File.dirname(__FILE__))

# Base test class that provides run_client and some extra asserts for checking
# client output and results
class ClientTestCase < Minitest::Test

  def run_client(prog, *args)
    prog = File.join(BIN_DIR, prog)
    args = [ RbConfig.ruby, prog ] + args.map { |a| a.to_s }
    proc = IO.popen(args)
    # Modify proc.to_s to print args
    eigenclass = class << proc; self; end
    eigenclass.class_eval { define_method(:to_s) { args.join ' ' } }
    proc
  end

  def assert_wait(proc, status=0, msg=nil)
    Process.wait(proc.pid)
    assert_equal status, $?.exitstatus, msg
  end

  def assert_output(proc, output, status=0, msg=nil)
    Process.wait(proc.pid)
    assert_equal output, proc.read, msg || "unexpected output: #{proc}"
    assert_equal status, $?.exitstatus, msg || "unexpected status: #{proc}"
  end

  # Run the block, assert run time is within some error margin of expect  
  def assert_time(expect, msg=nil)
    assert_in_delta(expect, Benchmark.measure { yield }.real, 0.2, msg)
  end

  def test_send_receive
    r = run_client("cli-proton-ruby-receiver", "--log-msgs=body")
    s = run_client("cli-proton-ruby-sender", "--msg-content=hello")
    assert_output s, ""
    assert_output r, "'hello'\n"
  end

  def test_connector_timeout
    s = TCPServer.new ""
    port = s.connect_address.ip_port
    assert_time(0.1) do
      r = run_client("cli-proton-ruby-connector", "--timeout=0.1", "--broker=:#{port}")
      assert_output r, "timeout expired\n"
    end
  ensure
    s.close if s
  end

  def test_receive_timeout
    assert_time(0.1) do         # Nothing to receive, time out immediately
      r = run_client("cli-proton-ruby-receiver", "--log-msgs=body", "--timeout=0.1")
      assert_output r, "timeout expired\n"
    end

    # Send messages to reset the timeout at least once
    r = run_client("cli-proton-ruby-receiver", "--log-msgs=body", "--timeout=0.2", "--count=4")
    3.times do                  # Send a message every 0.1 seconds
      bm = Benchmark.measure do
        s = run_client("cli-proton-ruby-sender", "--msg-content=hello")
        assert_output s, ""
      end
      t = 0.1 - bm.real
      sleep t if t > 0
    end
    assert_time(0.2) do
      assert_output r, ("'hello'\n" * 3) + "timeout expired\n"
    end
  end
end
