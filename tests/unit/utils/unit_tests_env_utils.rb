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

require_relative '../../../lib/utils/env_utils'

# EnvUtils unit tests class
class UnitTestsEnvUtils < Minitest::Test

  def test_env_utils_set_log_lib_env_frm
    ENV.clear
    EnvUtils.set_log_lib_env('TRANSPORT_FRM')
    assert_equal(
      "true",
      ENV['PN_TRACE_FRM']
    )
  end # test_env_utils_set_log_lib_env_frm

  def test_env_utils_set_log_lib_env_drv
    ENV.clear
    EnvUtils.set_log_lib_env('TRANSPORT_DRV')
    assert_equal(
      "true",
      ENV['PN_TRACE_DRV']
    )
  end # test_env_utils_set_log_lib_env_drv

  def test_env_utils_set_log_lib_env_raw
    ENV.clear
    EnvUtils.set_log_lib_env('TRANSPORT_RAW')
    assert_equal(
      "true",
      ENV['PN_TRACE_RAW']
    )
  end # test_env_utils_set_log_lib_env_raw

  def test_env_utils_set_log_lib_env_none
    ENV.clear
    EnvUtils.set_log_lib_env('NONE')
    assert_nil(
      ENV['PN_TRACE_FRM']
    )
    assert_nil(
      ENV['PN_TRACE_DRV']
    )
    assert_nil(
      ENV['PN_TRACE_RAW']
    )
    assert ENV.empty?
  end # test_env_utils_set_log_lib_env_none

  def test_env_utils_set_log_lib_env_raise
    assert_raises ArgumentError do
     EnvUtils.set_log_lib_env('RAISE')
    end
  end # test_env_utils_set_log_lib_env_raise

  def test_env_utils_set_log_lib_env_raise_message
    wrong_value = "RAISE"
    exception = assert_raises ArgumentError do
     EnvUtils.set_log_lib_env(wrong_value)
    end
    assert_equal(
      "Invalid client library logging level: #{wrong_value}",
      exception.message
    )
  end # test_env_utils_set_log_lib_env_raise_message

end # class UnitTestsEnvUtils

# eof
