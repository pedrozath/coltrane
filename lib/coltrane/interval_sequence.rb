class IntervalSequence
  attr_reader :intervals

  def initialize(arg)
    arg = [arg] if arg.class != Array
    @intervals = arg.reduce([]) do |memo, arg_item|
      case arg_item
      when Numeric  then memo << Interval.new(arg_item)
      when Interval then memo << arg_item
      when NoteSet  then memo + intervals_from_note_set(arg_item)
      end
    end
  end

  def intervals_from_note_set(note_set)
    note_numbers = note_set.notes.collect(&:number)
    root         = note_numbers.shift
    note_numbers.reduce([Interval.new(0)]) do |memo, number|
      number += 12 if number < root
      memo << Interval.new(number - root)
    end
  end

  def all
    intervals
  end

  def next_inversion
    IntervalSequence.new(intervals.rotate(+1))
  end

  def previous_inversion
    IntervalSequence.new(intervals.rotate(-1))
  end

  def inversions
    Array.new(intervals.length) do |index|
      IntervalSequence.new(interval.rotate(index))
    end
  end

  def numbers
    intervals.collect(&:number)
  end

  def names
    intervals.collect(&:name)
  end
end
