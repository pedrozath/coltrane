# frozen_string_literal: true

module Coltrane
  # This module takes care of adding to progressions knowledge that is more
  # based on common standards and practices.
  module NotableProgressions
    PROGRESSIONS = {
      'Pop' => ['I-V-vi-IV', :major],
      'Jazzy Pop' =>  ['IM7-V7-vi7-IVM7',      :major],
      'Jazz' =>       ['ii7-V7-I7',            :major],
      'Jazz Minor' => ['ii7-V7-i7',            :major],
      'Blues' =>      ['IM7-IV7-I7-V7-IV7-I7', :major],
      'Jazz Blues' => ['I7-IV7-I7-V7-IV7-I7',  :major],
      'Fifties' =>    ['I-vi-IV-V',            :major],
      'Circle' =>     ['vi-ii-V-I',            :major],
      'Tune Up' =>    ['ii7-V7-IM7-i7-IV7-IVM7-VIIM7', :minor]
    }.freeze

    PROGRESSIONS.each do |name, values|
      notation, scale_name = values
      define_method name.underscore do |note|
        note  = note.is_a?(Note) ? note : Note[note]
        scale = Scale.public_send(scale_name, note)
        new(notation, scale: scale)
      end
    end
  end
end
