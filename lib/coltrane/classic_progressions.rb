# frozen_string_literal: true

module Coltrane
  # It's totally a wip yet.
  module ClassicProgressions
    PROGRESSIONS = {
      'Pop'          => %w[I V vi IV],
      'Blues'        => %w[I I I I IV IV I I V IV I I],
      # 'Jazz Blues'   => %w[I7 IV7 I7 I7 F7 F7 I7 ]
      'Fifties'      => %w[I IV V],
      # pop:        [:major, [1, 5, 6, 4]],
      # fifties:    [:major, [1, 6, 4, 5]],
      # blues:      [:major, [1, 4, 1, 5, 4, 1]],
      # jazz:       [:major, [2, 5, 1]],
      # jazz_minor: [:minor, [2, 5, 1]],
      # andalusian: [:minor, [1, 7, 6, 5]]
    }.freeze
  end
end
