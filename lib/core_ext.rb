# frozen_string_literal: true

# Stolen from Active Support and changed a bit
# may in the future be substituted by facets version
class String
  def underscore
    return self unless /[A-Z-]|::/.match?(self)
    word = to_s.gsub('::', '/')
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
    word.tr!('- ', '_')
    word.downcase!
    word
  end
end
