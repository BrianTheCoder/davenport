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
    to_time.utc
    %Q("#{strftime "%Y/%m/%d %H:%M:%S +0000"}")
  end
end