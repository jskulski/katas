require 'spec_helper'

describe Minesweeper do

  it 'given 4x4 acceptance test from kata page' do
    sample_field = [
        "*...",
        "....",
        ".*..",
        "...."
    ].join("\n")
    sample_output = [
        "*100",
        "2210",
        "1*10",
        "1110",
    ].join("\n")
    expect(Minesweeper.sweep sample_field).to eq(sample_output.concat("\n"))
  end

  it 'given 4x4 acceptance test from kata page' do
    sample_field = [
        "**...",
        ".....",
        ".*...",
    ].join("\n")
    sample_output = [
        "**100",
        "33200",
        "1*100",
    ].join("\n")
    expect(Minesweeper.sweep sample_field).to eq(sample_output.concat("\n"))
  end

  it 'returns zero mine count for a 1x1 grid without a mine' do
    field = Minesweeper.sweep '.'
    expect(field).to eq("0\n")
  end

  it 'returns mine for 1x1 grid with a mine' do
    field = Minesweeper.sweep '*'
    expect(field).to eq("*\n")
  end

  it 'returns a 3x3 map of 0s for a field without mines' do
    field = Minesweeper.sweep("...\n...\n...\n")
    expect(field).to eq("000\n000\n000\n")
  end

  it 'returns a 2x2 map with a count of 1 for a field with one mine' do
    field = Minesweeper.sweep("*.\n..")
    expect(field).to eq("*1\n11\n")
  end

  it 'returns a 3x3 map of 8 and mines for a field with all mines' do
    field = Minesweeper.sweep("***\n*.*\n***\n")
    expect(field).to eq("***\n*8*\n***\n")
  end

  it 'given a 3x3 a matrix and a center coordinate it returns correct spaces to check' do
    matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    expect(Minesweeper.find_adjacent_squares(1, 1, matrix)).to eq([1, 2, 3, 4, 6, 7, 8, 9])
  end

  it 'given a 2x2 matrix and a top right coordinate, it returns the other three spaces' do
    matrix = [[1,2], [3,4]]
    expect(Minesweeper.find_adjacent_squares(0, 1, matrix)).to eq([1, 3, 4])
  end

  it 'given a 2x2 matrix and a bottom right coordinate, it returns the other three spaces' do
    matrix = [[1,2], [3,4]]
    expect(Minesweeper.find_adjacent_squares(1, 1, matrix)).to eq([1, 2, 3])
  end

end
