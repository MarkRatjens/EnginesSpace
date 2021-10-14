module Transforming
  class Transformable < ::Spaces::Model

    class << self
      def zero; @@zero ||= EnginesZero.new ;end
    end

    delegate zero: :klass

    def complete?; true ;end

    def identifier; struct[:identifier] ;end

    def blueprint_identifier; identifier.split_compound.last ;end

    def identifier_separator; ''.with_identifier_separator; end

    def random(length); SecureRandom.hex(length.to_i) ;end

    protected

    def all_complete?(array)
      array.map(&:complete?).all_true?
    end

  end
end
