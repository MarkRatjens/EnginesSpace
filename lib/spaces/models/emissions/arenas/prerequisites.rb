module Arenas
  module Prerequisites
    include ::Providers::Providers

    def provider_role_map
      @provider_role_map ||= struct.input.providers&.to_h || {}
    end

    def prerequisite_map
      @prerequisite_map ||= provider_qualifier_map.transform_values do |v|
        resolution_map[v] || resolution_map[v.camelize.downcase]
      end.compact
    end

    def prerequisite_keys; prerequisite_map.keys ;end

    #???????????????????????????????????????????????????????????????????????????
    def runtime_provider; provider_for(:runtime) ;end
    def packing_provider; provider_for(:packing) ;end
    def provisioning_provider; provider_for(:provisioning) ;end

    def runtime_qualifier; runtime_provider.qualifier ;end
    def packing_qualifier; packing_provider.qualifier ;end
    def provisioning_qualifier; provisioning_provider.qualifier ;end
    #???????????????????????????????????????????????????????????????????????????

  end
end
