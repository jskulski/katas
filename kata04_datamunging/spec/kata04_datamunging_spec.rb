require 'spec_helper'

describe Kata04Datamunging do
  it 'has a version number' do
    expect(Kata04Datamunging::VERSION).not_to be nil
  end

  it 'given two days, it returns the day with the least spread between max and min' do
    day1 = Day.new(1, 99, 100)
    day2 = Day.new(2, 50, 100)
    day = Kata04Datamunging.find_min_spread(day1, day2)
    expect(day).to eq(day1)
  end

  it 'actually compares the days' do
    day1 = Day.new(1, 50, 100)
    day2 = Day.new(2, 99, 100)
    day = Kata04Datamunging.find_min_spread(day1, day2)
    expect(day).to eq(day2)
  end

  it 'compares three days' do
    day1 = Day.new(1, 50, 100)
    day2 = Day.new(2, 75, 100)
    day3 = Day.new(3, 55, 100)
    day = Kata04Datamunging.find_min_spread(day1, day2, day3)
    expect(day).to eq(day2)
  end

  it 'converts a line in weather.dat to a day' do
    weather_line = '   1  88    59    74          53.8       0.00 F       280  9.6 270  17  1.6  93 23 1004.5'
    day = Kata04Datamunging.line_to_day(weather_line)

    expect(day.day_number).to eq(1)
    expect(day.min_temp).to   eq(59)
    expect(day.max_temp).to   eq(88)
  end

  it 'end to end: reads in weather.dat and displays the day with smallest spread' do
    day = Kata04Datamunging.find_day_with_lowest_spread('data/weather_test.dat')
    expect(day.day_number).to eq(2)
  end

  it 'end to end: real data' do
    day = Kata04Datamunging.find_day_with_lowest_spread('data/weather.dat')
    puts day.day_number
  end
end

describe FootballStats do
  it 'converts a football stat line to a FootballStat' do
    line = '    1. Arsenal         38    26   9   3    79  -  36    87'
    football_stat = FootballStats.line_to_stat line
    expect(football_stat.team_name).to eq('Arsenal')
    expect(football_stat.goals_for).to eq(79)
    expect(football_stat.goals_against).to eq(36)
  end

  it 'we can compare two football stats and get the one with the smallest spread' do
    stat1 = FootballStat.new('Bigger Spread', 100, 0)
    stat2 = FootballStat.new('Smaller Spread', 100, 99)
    stat = FootballStats.smallest_spread(stat1, stat2)
    expect(stat).to be(stat2)
  end

  it 'we can compare three stats' do
    stat1 = FootballStat.new('Bigger Spread', 100, 0)
    stat2 = FootballStat.new('Smaller Spread', 100, 99)
    stat3 = FootballStat.new('Middle Spread', 100, 50)
    stat = FootballStats.smallest_spread(stat1, stat2, stat3)
    expect(stat).to be(stat2)
  end

  it 'reads in a test data file and gives us the expected winner' do
    stat = FootballStats.read_file_and_return_smallest_spread('data/football_test.dat')
    expect(stat.team_name).to eq('Expected_Winner')
  end

  it 'does the kata' do
    stat = FootballStats.read_file_and_return_smallest_spread('data/football.dat')
    puts stat.team_name
  end

end
