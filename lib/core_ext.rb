# frozen_string_literal: true

# Stolen from Active Support and changed a bit
# may in the future be substituted by facets version
class Regexp
  def match?(*args)
    !!match(*args)
  end
end

class String
  def underscore
    return self unless /[A-Z-]|::/.match?(self)
    to_s.gsub('::', '/')
        .gsub(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .tr('- ', '_')
        .downcase
  end

  def match?(*args)
    !!match(*args)
  end

  def symbolize
    underscore.to_sym
  end
end

# Here we add some syntax sugar to make the code more understandable later
class Numeric
end

# Here we add some methods better work with Tries
class Hash
  def dig(*args)
    args.size > 1 ? self[args.shift].dig(*args) : self[args[0]]
  end

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
