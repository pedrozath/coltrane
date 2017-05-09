class ScaleCache < ActiveRecord::Base
  has_many :scale_chords
  has_many :chord_caches, through: :scale_chords
end