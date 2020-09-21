require_relative '../emitting/subdivision'

module Packages
  class Package < ::Emitting::Subdivision

    class << self
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :scripts

  end
end
