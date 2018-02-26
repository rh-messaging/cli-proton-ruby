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

require_relative '../../../lib/utils/string_utils'

# StringUtils unit tests class
class UnitTestsStringUtils < Minitest::Test

  # is_int
  def test_string_utils_is_int_true_in_string
    refute StringUtils.str_is_int?("true")
  end

  def test_string_utils_is_int_false_in_string
    refute StringUtils.str_is_int?("false")
  end

  def test_string_utils_is_int_positive_int_in_string
    assert StringUtils.str_is_int?("1")
  end

  def test_string_utils_is_int_negative_int_in_string
    assert StringUtils.str_is_int?("-1")
  end

  def test_string_utils_is_int_positive_float_in_string
    refute StringUtils.str_is_int?("1.3")
  end

  def test_string_utils_is_int_negative_float_in_string
    refute StringUtils.str_is_int?("-1.3")
  end

  def test_string_utils_is_int_range_in_string
    refute StringUtils.str_is_int?("1..10")
  end

  def test_string_utils_is_int_empty_array_in_string
    refute StringUtils.str_is_int?("[]")
  end

  def test_string_utils_is_int_simple_array_in_string
    refute StringUtils.str_is_int?("['A', 'B', 'C']")
  end

  def test_string_utils_is_int_empty_hash_in_string
    refute StringUtils.str_is_int?("{}")
  end

  def test_string_utils_is_int_simple_hash_in_string
    refute StringUtils.str_is_int?("{1=>'A', 2=>'B', 3=>'C'}")
  end

  def test_string_utils_is_int_empty_string_in_string
    refute StringUtils.str_is_int?("")
  end

  def test_string_utils_is_int_simple_string_in_string
    refute StringUtils.str_is_int?("string")
  end

  def test_string_utils_is_int_symbol_in_string
    refute StringUtils.str_is_int?(":ruby_symbol")
  end

  def test_string_utils_is_int_nil_in_string
    refute StringUtils.str_is_int?("nil")
  end

  # is_float

  def test_string_utils_is_float_true_in_string
    refute StringUtils.str_is_float?("true")
  end

  def test_string_utils_is_float_false_in_string
    refute StringUtils.str_is_float?("false")
  end

  def test_string_utils_is_float_positive_int_in_string
    assert StringUtils.str_is_float?("1")
  end

  def test_string_utils_is_float_negative_int_in_string
    assert StringUtils.str_is_float?("-1")
  end

  def test_string_utils_is_float_positive_float_in_string
    assert StringUtils.str_is_float?("1.3")
  end

  def test_string_utils_is_float_negative_float_in_string
    assert StringUtils.str_is_float?("-1.3")
  end

  def test_string_utils_is_float_range_in_string
    refute StringUtils.str_is_float?("1..10")
  end

  def test_string_utils_is_float_empty_array_in_string
    refute StringUtils.str_is_float?("[]")
  end

  def test_string_utils_is_float_simple_array_in_string
    refute StringUtils.str_is_float?("['A', 'B', 'C']")
  end

  def test_string_utils_is_float_empty_hash_in_string
    refute StringUtils.str_is_float?("{}")
  end

  def test_string_utils_is_float_simple_hash_in_string
    refute StringUtils.str_is_float?("{1=>'A', 2=>'B', 3=>'C'}")
  end

  def test_string_utils_is_float_empty_string_in_string
    refute StringUtils.str_is_float?("")
  end

  def test_string_utils_is_float_simple_string_in_string
    refute StringUtils.str_is_float?("string")
  end

  def test_string_utils_is_float_symbol_in_string
    refute StringUtils.str_is_float?(":ruby_symbol")
  end

  def test_string_utils_is_float_nil_in_string
    refute StringUtils.str_is_float?("nil")
  end

end # class UnitTestsStringUtils

# eof
