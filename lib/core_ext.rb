class String
  # Stolen from Active Support and changed a bit
  def underscore
    return self unless /[A-Z-]|::/.match?(self)
    word = self.to_s.gsub("::", "/")
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end
end