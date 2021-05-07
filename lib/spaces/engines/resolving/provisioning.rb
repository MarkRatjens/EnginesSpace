module Resolving
  module Provisioning

    def provisioned
      empty_provisions.tap do |m|
        m.predecessor = self
        m.cache_resolution_identifiers(arena_identifier, blueprint_identifier)
      end
    end

    def provisionable?
      !defines_runtime?
    end

    def defines_runtime?
      blueprint_identifier == runtime_binding&.target_identifier
    end

    def divisions_including_providers
      [divisions, arena.providers].flatten.reject do |d|
        correlating_provider_classes.include?(d.class)
      end
    end

    def correlating_provider_classes
      @correlating_provider_classes ||=
        divisions.map(&:class).intersection(arena.providers.map(&:class))
    end

    def empty_provisions; provisions_class.new ;end
    def provisions_class; ::Provisioning::Provisions ;end

  end
end
