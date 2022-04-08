require_relative 'space'

module Spaces
  class DelegatedSpace < Space

    def identifiers; summaries.map(&:identifier) ;end

    def all
      interfaces.map(&:all).flatten
    end

    def summaries; all ;end

    def interfaces; [] ;end

  end
end