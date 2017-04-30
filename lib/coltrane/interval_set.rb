
# class IntervalSet
#   def initialize(*intervals)
#     @intervals = intervals
#     @number_of_frets = 24
#     sum = @intervals.reduce(:+)
#     sum < 12 && @intervals << 12 - sum
#   end

#   def to_s
#     @intervals.to_s
#   end

#   def to_frets(offset = 0)
#     frets = [-offset]
#     i = 0
#     while frets.last < @number_of_frets
#       frets << frets.last + @intervals[i % @intervals.length]
#       i += 1
#     end
#     frets
#   end
# end
