# require 'coltrane'
# require 'paint'

# def get_user_input(message)
#   puts message
#   gets
# end

# def get_intervals_from_user
#   get_user_input('Please type intervals divided by commas (,)')
#     .delete("\n").split(',').map(&:to_i)
# end

# def main
#   GuitarScale.new(
#     IntervalSequence.new(*get_intervals_from_user)
#   ).print
#   main
# end

# main