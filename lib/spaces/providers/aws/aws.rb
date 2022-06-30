module Providers
  module Aws
    class Aws < ::Providers::Provider

      def repository_identifier
        "#{account_identifier}.dkr.ecr.#{region}.amazonaws.com"
      end

    end
  end
end
