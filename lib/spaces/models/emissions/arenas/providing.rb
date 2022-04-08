module Arenas
  module Providing

    def providers
      role_providers.map(&:provider)
    end

    def provider_for(role_identifier)
      role_providers.named(role_identifier)&.provider
    end

    def qualifier_for(role_identifier)
      provider_for(role_identifier).qualifier
    end

    def resolution_for(role_identifier)
      provider_for(role_identifier).resolution
    end

    #???????????????????????????????????????????????????????????????????????????
    def runtime_provider; provider_for(:runtime) ;end
    def packing_provider; provider_for(:packing) ;end
    def orchestration_provider; provider_for(:orchestration) ;end

    def runtime_qualifier; qualifier_for(:runtime) ;end
    def packing_qualifier; qualifier_for(:packing) ;end
    def orchestration_qualifier; qualifier_for(:orchestration) ;end
    #???????????????????????????????????????????????????????????????????????????

  end
end