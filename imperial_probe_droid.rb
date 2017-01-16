class ImperialProbeDroid
  attr_reader :serial_number

  def initialize(data = Hash.new)
    @serial_number = data[:serial_number]
    @power_level = data[:power_level]
    @blaster_status = data[:blaster_status]
    @scanner_status = data[:scanner_status]
  end

  def check_power_level
    return "Power at Maximum." if @power_level == 100
    return "Power at #{@power_level}%." if @power_level < 100 && @power_level >= 25
    return "Low Power! #{@power_level}% Remaining!" if @power_level < 25 && @power_level > 0
    return "No Power, Recharge Now!" if @power_level == 0
  end

  def scan
    if scanner_functioning?
      @power_level -= 10
      "Scanning"
    else
      "Scanner Malfunction!"
    end
  end

  def fire_blaster
    if blaster_functioning?
      @power_level -= 5
      return "Bang"
    else
      return "Blaster Malfunction!"
    end
  end

  def recharge_power
    @power_level = 100
  end

  def rapid_fire(shot_count)
    result = Array.new
    shot_count.times do
      result << fire_blaster
    end
    result.join(", ")
  end

  def scanner_functioning?
    @power_level >= 10 && @scanner_status == "OK"
  end

  def blaster_functioning?
    @power_level >= 5 && @blaster_status == "OK"
  end

end
