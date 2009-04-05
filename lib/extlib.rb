class Fixnum
  def ordinalize
    if (11..13).include?(self % 100)
      "#{self}th"
    else
      case self % 10
        when 1; "#{self}st"
        when 2; "#{self}nd"
        when 3; "#{self}rd"
        else    "#{self}th"
      end
    end
  end
end

class Array
  def groups(number)
    group_size = self.size / number
    length = self.size
    groups = []
    clone = self.dup
    number.times do |i|
      groups << ((length % number >= i + 1) ? clone.slice!(0,group_size + 1) : clone.slice!(0,group_size))
    end
    groups
  end
end

module Enumerable
  def group_by
    inject({}) do |groups, element|
      (groups[yield(element)] ||= []) << element
      groups
    end
  end
end
 
class Range
  ##
  # Takes a range and converts it to an array of days
  #
  # (Time.now..7.days.from_now).to_days
  #
  def to_days
    return if first > last
    arr = []
    time = first
    while time <= last
      arr << time
      time += 1.day
    end
    return arr
  end
  ##
  # Takes a range and converts it to an array of hours
  #
  # (Time.now..1.day.from_now).to_hours
  #
  def to_hours
    return if first > last
    arr = []
    time = first
    while time <= last
      arr << time
      time += 1.hour
    end
    return arr
  end
end

class DateTime
  def to_json
    %Q("#{strftime("%Y/%m/%d %H:%M:%S")} #{zone}")
  end
end

class Array
  def pick
    at Kernel.rand(size)
  end
end

class Integer
  def of
    (1..self).to_a.map { yield }
  end
end

class Range
  def pick
    to_a.pick
  end

  def of
    pick.of { yield }
  end
end