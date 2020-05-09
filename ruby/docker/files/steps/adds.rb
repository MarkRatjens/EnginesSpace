require_relative 'requires'

module Docker
  module Files
    module Steps
      class Adds < Docker::Files::Step

        def instructions
          %Q(
          ADD build build
          ADD home home
          )
        end

      end
    end
  end
end
