require "minesweeper/version"

module Minesweeper
  def Minesweeper.sweep(terrain)
    matrix = terrain.split.map { |l| l.split('') }

    mine_map = matrix.map.with_index do |row, r|
      row.map.with_index do |quad, c|
        score = calculate_score(r, c, matrix)
        convert_quad_to_map_square(quad, score)
      end
    end

    mine_map.reduce('') { |s, row| s << row.join << "\n" }
  end

  def self.calculate_score(r, c, matrix)
    find_adjacent_squares(r, c, matrix).select { |x| x == '*' }.length
  end

  def Minesweeper.find_adjacent_squares(row, col, matrix)
    rows = [0, row-1].max..[row+1, matrix.length - 1].min
    cols = [0, col-1].max..[col+1, matrix.length - 1].min

    spaces_to_check = []
    rows.each do |r|
      cols.each { |c| spaces_to_check.push([r, c]) if [r, c] != [row, col] }
    end

    return spaces_to_check.map { |r, c| matrix[r][c] }
  end

  def self.convert_quad_to_map_square(quad, score)
    quad == "*" ? "*" : score
  end
end
