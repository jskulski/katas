require "kata04_datamunging/version"

module Kata04Datamunging
  def Kata04Datamunging.find_min_spread(*days)
    min_day = Day.new(-999, -999, 999)
    days.each do |day|
      spread1 = min_day.max_temp - min_day.min_temp
      spread2 = day.max_temp - day.min_temp
      min_day = spread2 < spread1 ? day : min_day
    end
    return min_day
  end

  def Kata04Datamunging.line_to_day(line)
    data = line.split.map {|d| d.to_i}
    Day.new data[0], data[2], data[1]
  end

  def Kata04Datamunging.find_day_with_lowest_spread(filename)
    days = []
    File.foreach(filename) do |line|
      days.push line_to_day(line) if line.strip.match(/^\d/)
    end
    find_min_spread(*days)
  end
end

class Day
  attr_reader :day_number, :min_temp, :max_temp

  def initialize(day_number, min_temp, max_temp)
    @day_number = day_number
    @min_temp = min_temp
    @max_temp = max_temp
  end
end


module FootballStats
  def FootballStats.line_to_stat(line)
    data = line.split
    team_name = data[1]
    goals_for = data[6].to_i
    goals_against = data[8].to_i
    FootballStat.new(team_name, goals_for, goals_against)
  end

  def FootballStats.smallest_spread(*stats)
    stat1 = stats[0]
    stat2 = stats[1]
    min_stat = FootballStat.new("Fake", 999, -999)
    stats.each do |test_stat|
      min_spread = min_stat.goals_for - min_stat.goals_against
      test_spread = test_stat.goals_for - test_stat.goals_against
      min_stat = test_spread < min_spread ? test_stat : min_stat
    end
    return min_stat
  end

  def FootballStats.read_file_and_return_smallest_spread(filename)
    stats = []
    File.foreach(filename) do |line|
      stats.push FootballStats.line_to_stat(line) if line.strip.match(/^\d\./)
    end
    smallest_spread(*stats)
  end

end

class FootballStat
  attr_reader :team_name, :goals_for, :goals_against
  def initialize(team_name, goals_for, goals_against)
    @team_name = team_name
    @goals_for = goals_for
    @goals_against = goals_against
  end
end

