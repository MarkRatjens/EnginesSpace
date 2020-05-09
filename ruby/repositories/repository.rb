require_relative '../collaborators/subdivision'

module Repositories
  class Repository < ::Collaborators::Subdivision

    class << self
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :scripts
    
  end
end
