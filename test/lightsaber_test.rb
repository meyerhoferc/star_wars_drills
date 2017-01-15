require_relative 'test_helper'
require './lib/lightsaber'

class LightsaberTest < Minitest::Test
  def test_it_is_a_lightsaber
    lightsaber = Lightsaber.new("green")
    assert_instance_of Lightsaber, lightsaber
  end

  def test_it_has_a_color
    skip 
    lightsaber = Lightsaber.new("green")
    assert_equal "green", lightsaber.color
  end

  def test_it_can_be_another_color
    skip
    lightsaber = Lightsaber.new("purple")
    assert_equal "purple", lightsaber.color
  end

  def test_it_knows_when_it_is_in_use
    skip
    lightsaber = Lightsaber.new("magneta")
    refute lightsaber.in_use?
    lightsaber.start
    assert lightsaber.in_use?
  end

  def test_it_is_single_blade_by_default
    skip
    lightsaber = Lightsaber.new("blue")
    assert_equal "single", lightsaber.type
  end

  def test_it_can_be_double_bladed
    skip
    lightsaber = Lightsaber.new("red", "double")
    assert_equal "double", lightsaber.type
  end
end
