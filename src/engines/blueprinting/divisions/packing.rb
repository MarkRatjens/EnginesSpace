module Divisions
  class Packing < ::Emissions::Division

    class << self
      def script_choices(precedence)
        Pathname.glob("#{__dir__}/scripts/#{precedence}/*")
      end

      def script_choices_names(precedence)
        script_choices(precedence).map(&:basename).map(&:to_s).map(&:to_sym)
      end

      def precedence_choices
        Pathname.glob("#{__dir__}/scripts/*").map(&:basename).map(&:to_s).map(&:to_sym)
      end
    end

    def packing_stanza_for(precedence)
      {
        type: 'shell',
        scripts: send(precedence).map { |s| "#{temporary_packing_path}/#{precedence}/#{s}" }
      }
    end

  end
end
