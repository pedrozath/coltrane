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

  def interval_quality
    {
      'P' => 'Perfect',
      'm' => 'Minor',
      'M' => 'Major',
      'A' => 'Augmented',
      'd' => 'Diminished'
    }[self]
  end
end

# Here we add some syntax sugar to make the code more understandable later
class Integer
  def interval_name
    {
      1   => 'Unison',
      2   => 'Second',
      3   => 'Third',
      4   => 'Fourth',
      5   => 'Fifth',
      6   => 'Sixth',
      7   => 'Seventh',
      8   => 'Octave',
      9   => 'Ninth',
      10  => 'Tenth',
      11  => 'Eleventh',
      12  => 'Twelfth',
      13  => 'Thirteenth',
      14  => 'Fourteenth',
      15  => 'Double Octave'
    }[self % 16]
  end
end

# Here we add some methods better work with Tries
class Hash
  def clone_values(from_keys: nil,
                   to_keys: nil,
                   suffix: nil,
                   branch_a: nil,
                   branch_b: nil)
    branch_a ||= dig(*from_keys)
    if branch_b.nil?
      create_branch!(*to_keys)
      branch_b = dig(*to_keys)
    end

    branch_a.each do |key, val|
      if val.is_a?(Hash)
        clone_values branch_a: branch_a[key],
                     branch_b: (branch_b[key] ||= {}),
                     suffix: suffix
      else
        branch_b[key] = "#{val.dup}#{suffix}"
      end
    end
  end

  def create_branch!(*keys)
    return nil if keys.empty?
    key = keys.shift
    (self[key] ||= {}).create_branch!(*keys)
  end

  def deep_dup
    dup_hash = {}
    each do |k, v|
      dup_hash[k] = if v.is_a?(Hash)
                      v.deep_dup
                    else
                      v.dup
                    end
    end
    dup_hash
  end
end
