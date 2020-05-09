require_relative 'thing'
require_relative 'descriptor'

module Spaces
  class Model < Thing
    extend Forwardable

    class << self
      def universe; @universal_space ||= Universal::Space.new ;end
      def schema; @schema ||= schema_class.new ;end

      def schema_class
        require_relative("../#{namespace}/schema")
        Module.const_get("#{namespace}/schema".camelize)
      rescue LoadError
        Schema
      end
    end

    relation_accessor :descriptor

    delegate(
      [:universe, :schema, :schema_class] => :klass,
      [:outline, :deep_outline] => :schema
    )

    def descriptor
      @descriptor ||= descriptor_class.new(struct.descriptor)
    end

    def file_name; klass.qualifier ;end
    def subpath; end
    def uniqueness; [klass.name, identifier] ;end
    def capture_foreign_keys; end
    def descriptor_class; Descriptor ;end

    def namespaced_name(namespace, symbol)
      "#{namespace}::#{symbol.to_s.split('_').map(&:capitalize).join}"
    end

  end
end
