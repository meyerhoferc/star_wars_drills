require_relative 'test_helper'
require './lib/tauntaun'

class TauntaunTest < Minitest::Test
  def test_it_is_a_tauntaun
    tauntaun = Tauntaun.new("Greg")
    assert_instance_of Tauntaun, tauntaun
  end

  def test_it_has_a_name
    tauntaun = Tauntaun.new("Greg")
    assert_equal "Greg", tauntaun.name
  end

  def test_it_be_a_different_name
    tauntaun = Tauntaun.new("Alex")
    assert_equal "Alex", tauntaun.name
  end

  def test_it_has_helpful_demeanor_by_default
    tauntaun = Tauntaun.new("Ed")
    assert_equal "helpful", tauntaun.demeanor
  end

  def test_it_can_have_a_different_demeanor
    tauntaun = Tauntaun.new("Ed", "sassy")
    assert_equal "sassy", tauntaun.demeanor
  end

  def test_it_is_not_hungry_by_default
    tauntaun = Tauntaun.new("Alex")
    refute tauntaun.hungry?
  end

  def test_after_being_ridden_it_is_hungry
    tauntaun = Tauntaun.new("Casey")
    refute tauntaun.hungry?
    assert tauntaun.ride?
    assert tauntaun.hungry?
  end

  def test_tauntaun_refuses_to_be_ridden_when_hungry
    tauntaun = Tauntaun.new("Bertha")
    refute tauntaun.hungry?
    assert tauntaun.ride?
    assert tauntaun.hungry?
    refute tauntaun.ride?
  end
end
