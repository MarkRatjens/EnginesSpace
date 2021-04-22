module Provisioning
  class Provisions < ::Emissions::Emission

    class << self
      def composition_class; Composition ;end
    end

    alias_accessor :resolution, :predecessor

    delegate(
      [:arena, :images, :volumes, :connect_bindings] => :resolution
    )

    def keys; composition.keys ;end

    def connections_provisioned
      connections_down.map(&:provisioned)
    end

    def artifact; stanzas.join("\n") ;end

    def stanzas
      divisions_including_resolution_divisions.map { |d| d.resolution_stanzas_for(self) }.flatten.compact
    end

    def divisions_including_resolution_divisions
      [divisions, resolution.divisions_including_provider_divisions].flatten
    end

  end
end