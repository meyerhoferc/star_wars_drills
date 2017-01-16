require './test/test_helper'
require './lib/imperial_probe_droid'

class ImperialProbeDroidTest < Minitest::Test

  def good_data
    {
      serial_number: "C2-B3",
      power_level: 100,
      blaster_status: "OK",
      scanner_status: "OK",
      hull_strength: 100
    }
  end

  def bad_data
    {
      serial_number: "C2-B3",
      power_level: 100,
      blaster_status: "AAAHH",
      scanner_status: "Not Working"
    }
  end

  def test_can_create_probe_droid
    probe_droid = ImperialProbeDroid.new

    assert_instance_of ImperialProbeDroid, probe_droid
  end

  def test_has_serial_number
    probe_droid = ImperialProbeDroid.new(good_data)

    assert_equal "C2-B3", probe_droid.serial_number
  end

  def test_default_power_level
    probe_droid  = ImperialProbeDroid.new(good_data)

    assert_equal "Power at Maximum.", probe_droid.check_power_level
  end

  def test_if_scanner_is_functioning
    probe_droid = ImperialProbeDroid.new(good_data)
    probe_droid2 = ImperialProbeDroid.new(bad_data)

    assert_equal true, probe_droid.scanner_functioning?
    refute probe_droid2.scanner_functioning?
  end

  def test_can_scan_and_use_power
    probe_droid = ImperialProbeDroid.new(good_data)

    assert_equal "Scanning", probe_droid.scan
    assert_equal "Power at 90%.", probe_droid.check_power_level
  end

  def test_scanner_malfunction
    probe_droid = ImperialProbeDroid.new(bad_data)

    assert_equal "Scanner Malfunction!", probe_droid.scan
  end

  def test_if_blaster_is_functioning
    probe_droid = ImperialProbeDroid.new(good_data)
    probe_droid2 = ImperialProbeDroid.new(bad_data)

    assert_equal true, probe_droid.blaster_functioning?
    refute probe_droid2.blaster_functioning?
  end

  def test_can_fire_blaster
    probe_droid = ImperialProbeDroid.new(good_data)

    assert_equal "Bang", probe_droid.fire_blaster
    assert_equal "Power at 95%.", probe_droid.check_power_level
  end

  def test_can_recharge_power
    probe_droid = ImperialProbeDroid.new(good_data)

    15.times { probe_droid.fire_blaster }

    assert_equal "Power at 25%.", probe_droid.check_power_level

    probe_droid.recharge_power

    assert_equal "Power at Maximum.", probe_droid.check_power_level

  end

  def test_low_power_prompt
    probe_droid = ImperialProbeDroid.new(good_data)

    16.times { probe_droid.fire_blaster }

    assert_equal "Low Power! 20% Remaining!", probe_droid.check_power_level
  end

  def test_run_out_of_power_power_warning
    probe_droid = ImperialProbeDroid.new(good_data)

    20.times { probe_droid.fire_blaster }

    assert_equal "Blaster Malfunction!", probe_droid.fire_blaster
    assert_equal "No Power, Recharge Now!", probe_droid.check_power_level
  end

  def test_rapid_fire
    probe_droid = ImperialProbeDroid.new(good_data)

    assert_equal "Bang, Bang, Bang", probe_droid.rapid_fire(3)
    assert_equal "Power at 85%.", probe_droid.check_power_level
  end

  def test_hull_integrity
    probe_droid = ImperialProbeDroid.new(good_data)

    assert_equal "Hull is at Maximum Strength!", probe_droid.check_hull_integrity
  end

  def test_hull_can_take_damage
    probe_droid = ImperialProbeDroid.new(good_data)

    probe_droid.take_damage(4)
    probe_droid.take_damage(10)
    assert_equal "Hull is at 86%!", probe_droid.check_hull_integrity
  end

end
