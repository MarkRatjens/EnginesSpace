module Divisions
  class Deployment < ::Divisions::Division

    class << self
      def prototype(emission:, label:)
        class_for(:divisions, emission.orchestration_qualifier, qualifier).new(emission: emission, label: label)
      rescue NameError
        new(emission: emission, label: label)
      end
    end

  end
end
