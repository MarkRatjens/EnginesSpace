class Hash

  def symbolize_keys
    transform_keys(&:to_sym)
  end

  def stringify_keys
    transform_keys(&:to_s)
  end

  def without(*keys)
    duplicate(self).without!(*keys)
  end

  def without!(*keys)
    keys.each { |key| delete(key) }
    self
  end

  def clean
    compact.delete_if { |k, v| v == '' }
  end

  def reverse_merge(other = {})
    other.merge(self)
  end

  def reverse_merge!(other_hash)
    replace(reverse_merge(other_hash))
  end

  def to_struct
    OpenStruct.new(values_to_struct)
  end

  def no_symbols; stringify_keys.deep(:no_symbols) ;end
  def values_to_struct; deep(:to_struct) ;end

  def deep(method)
    transform_values do |v|
      v.send(method)
    rescue NoMethodError
      v
    end
  end

end