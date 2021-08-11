require_relative 'binding'
require_relative 'providing'
require_relative 'blueprinting'
require_relative 'installing'
require_relative 'resolving'
require_relative 'packing'
require_relative 'provisioning'
require_relative 'summary'
require_relative 'state'

module Arenas
  class Arena < ::Emissions::Emission
    include ::Arenas::Binding
    include ::Arenas::Providing
    include ::Arenas::Blueprinting
    include ::Arenas::Installing
    include ::Arenas::Resolving
    include ::Arenas::Packing
    include ::Arenas::Provisioning
    include ::Arenas::Summary
    include ::Arenas::State

    class << self
      def composition_class; Composition ;end
    end

    delegate([:arenas, :blueprints, :installations, :resolutions, :packs, :provisioning] => :universe)

    def more_binder_identifiers
      blueprints.binder_identifiers - target_identifiers
    end

    def runtime_binding
      @runtime_binding ||= deep_bindings.detect(&:runtime_binding?)
    end

    def packing_binding
      @packing_binding ||= deep_bindings.detect(&:packing_binding?)
    end

    def connectable_blueprints
      connected_blueprints.map do |b|
        b.binder? ? b.connected_blueprints.flatten.map(&:blueprint) : b
      end.flatten
    end

    def arena; itself ;end

    def method_missing(m, *args, &block)
      provider_map["#{m}"] || super
    end

    def respond_to_missing?(m, *)
      provider_map.keys.include?("#{m}") || super
    end

  end
end
