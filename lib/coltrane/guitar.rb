module Guitar
  def self.strings
    %w(E4 B3 G3 D3 A2 E2).map do |pitch|
      GuitarString.new(pitch)
    end
  end

  def self.frets
    22
  end
end