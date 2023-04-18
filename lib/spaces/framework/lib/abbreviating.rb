module Abbreviating

  def abbreviated(l: 32, segment_length: 4, separator: '-', calls: nil) =
    calls_signatures_for(l, segment_length, separator, calls).reduce(self) do |r, args|
      r.length > l ? r.send(*args) : r
    end

  def calls_signatures_for(l, segment_length, separator, calls) =
    (calls || default_calls).map do |c|
      [c, call_signatures(l, segment_length, separator)[c]].flatten
    end


  def default_calls =
    [
      :no_vowels_except_after,
      :segments_truncated_to,
      :without_separator,
      :enforce
    ]

  def call_signatures(l, segment_length, separator) =
    {
      no_vowels_except_after: [separator, segment_length],
      segments_truncated_to: [segment_length, separator],
      without_separator: separator,
      enforce: l
    }

  def no_vowels_except_after(separator, segment_length) =
    split(separator).
      map { |s| s.no_nonleading_vowels(segment_length) }.
      join(separator)

  def segments_truncated_to(segment_length, separator)
    split(separator).map do |s|
      s.integer? ? s.reverse : s[0, segment_length]
    end.join(separator)
  end

  def without_separator(separator) = gsub(separator, '')

  def enforce(l) = self[0, l - 1]

  def no_nonleading_vowels(segment_length) =
    length > segment_length ? "#{chr}#{self[1..-1].no_vowels}" : self

  def no_vowels = gsub(/[aeiouy]/i, '')
  def integer? = to_i.to_s == self

end
