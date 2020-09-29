module Provisioning
  class Provisions < ::Emissions::Emission

    relation_accessor :arena
    alias_accessor :resolution, :predecessor

    delegate([:divisions, :binding_descriptors] => :resolution)

    def emit
      super.tap { |m| m.descriptor = struct.descriptor }
    end

    def stanzas
      divisions.map(&:provisioning_stanzas).flatten.compact
    end

    def file_name; identifier ;end

    def initialize(resolution:, arena:)
      self.resolution = resolution
      self.arena = arena
      self.struct = OpenStruct.new
      self.struct.descriptor = resolution.descriptor.emit
    end

  end
end
