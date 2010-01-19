# Commercial week creates a Date object for the first day of the given week of the given year
# Example:
# * 1. week of 2010 => 2010-01-04
# * 52. week of 2009 => 2009-12-21
#
# (C) 2009 Alex Beregszaszi
#
# $MIT License$

require 'date'

class Date
  def self.commercial_week(year = 0, week = 0)
    return Date.today if week == 0
    year = Date.today.year if year == 0
    return Date.commercial(year, week, 1, GREGORIAN)
  end
end

#puts "Civil: #{Date.civil(2010, 1)}"
#puts "Todays week starting date: #{Date.commercial_week()}"
#puts "First week, current year: #{Date.commercial_week(0, 1)}"
#puts "2009 52. week: #{Date.commercial_week(2009, 52)}"
#puts "2010 3. week: #{Date.commercial_week(2010, 3)}"
