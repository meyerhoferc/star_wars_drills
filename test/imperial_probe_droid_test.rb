require './test/test_helper'
require './imperial_probe_droid'

class ImperialProbeDroidTest < Minitest::Test

  def good_data

  end

  def bad_data

  end

  def test_can_create_probe_droid
    probe_droid = ImperialProbeDroid.new

    assert_instance_of ImperialProbeDroid, probe_droid
  end

  def test_has_serial_number
    probe_droid = ImperialProbeDroid.new(serial_number: "C2-B3")

    assert_equal "C2-B3", probe_droid.serial_number
  end

  def test_default_power_level
    probe_droid  = ImperialProbeDroid.new(serial_number: "C2-B3", power_level: 100)

    assert_equal "Power at Maximum.", probe_droid.check_power_level
  end

  def test_if_scanner_is_functioning
    probe_droid = ImperialProbeDroid.new(serial_number: "C2-B3", power_level: 100, scanner_status: "OK")
    probe_droid2 = ImperialProbeDroid.new(serial_number: "C2-B3", power_level: 100, scanner_status: "Nope")

    assert_equal true, probe_droid.scanner_functioning?
    refute probe_droid2.scanner_functioning?
  end

  def test_can_scan_and_use_power
    probe_droid = ImperialProbeDroid.new(serial_number: "C2-B3", power_level: 100, scanner_status: "OK")

    assert_equal "Scanning", probe_droid.scan
    assert_equal "Power at 90%.", probe_droid.check_power_level
  end

  def test_scanner_malfunction
    probe_droid = ImperialProbeDroid.new(serial_number: "C2-B3", power_level: 100, blaster_status: "OK", scanner_status: "Uh-Oh")

    assert_equal "Scanner Malfunction!", probe_droid.scan
  end

  def test_if_blaster_is_functioning
    probe_droid = ImperialProbeDroid.new(serial_number: "C2-B3", power_level: 100, blaster_status: "OK", scanner_status: "OK")
    probe_droid2 = ImperialProbeDroid.new(serial_number: "C2-B3", power_level: 100, blaster_status: "AAAHH", scanner_status: "Not Working")

    assert_equal true, probe_droid.blaster_functioning?
    refute probe_droid2.blaster_functioning?
  end

  def test_can_fire_blaster
    probe_droid = ImperialProbeDroid.new(serial_number: "C2-B3", power_level: 100, blaster_status: "OK")

    assert_equal "Bang", probe_droid.fire_blaster
    assert_equal "Power at 95%.", probe_droid.check_power_level
  end

  def test_can_recharge_power
    probe_droid = ImperialProbeDroid.new(serial_number: "C2-B3", power_level: 100, blaster_status: "OK")

    15.times { probe_droid.fire_blaster }

    assert_equal "Power at 25%.", probe_droid.check_power_level

    probe_droid.recharge_power

    assert_equal "Power at Maximum.", probe_droid.check_power_level

  end

  def test_low_power_prompt
    probe_droid = ImperialProbeDroid.new(serial_number: "C2-B3", power_level: 100, blaster_status: "OK")

    16.times { probe_droid.fire_blaster }

    assert_equal "Low Power! 20% Remaining!", probe_droid.check_power_level
  end

  def test_run_out_of_power_power_warning
    probe_droid = ImperialProbeDroid.new(serial_number: "C2-B3", power_level: 100, blaster_status: "OK")

    20.times { probe_droid.fire_blaster }

    assert_equal "Blaster Malfunction!", probe_droid.fire_blaster
    assert_equal "No Power, Recharge Now!", probe_droid.check_power_level
  end

  def test_rapid_fire
    probe_droid = ImperialProbeDroid.new(serial_number: "C2-B3", power_level: 100, blaster_status: "OK")

    assert_equal "Bang, Bang, Bang", probe_droid.rapid_fire(3)
    assert_equal "Power at 85%.", probe_droid.check_power_level
  end

  def test_hull_integrity

end
