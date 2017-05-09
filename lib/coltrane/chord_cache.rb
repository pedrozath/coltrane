class ChordCache < ActiveRecord::Base
  has_many :scale_chords
  has_many :scale_caches, through: :scale_chords
end