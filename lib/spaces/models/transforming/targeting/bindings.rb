module Targeting
  class Bindings < ::Divisions::Divisible

    alias_method :all_bindings, :all

    def complete?; all_complete?(all) ;end

    def named(name)
      all.detect { |b| b.identifier == name.to_s }
    end

    def flattened
      empty.tap { |d| d.struct = all.map(&:flattened).map(&:struct) }
    end

    def graphed(type: :all, emission: emission_type, direction: nil)
      empty.tap do |d|
        d.struct = send("#{type}_bindings").map { |b| b.graphed(emission) }.compact.map(&:struct)
      end
    end

    def transformed_to(transformation)
      # TODO: cannot refer to blueprint here
      in_blueprint? ? super : super.select do |s|
        s.for_runtime?(runtime_qualifier)
      end
    end

    def embed_bindings
      all.select(&:embed?)
    end

    def embed_bindings_for(runtime)
      ebs = shallow_embed_bindings_for(runtime)
      [ebs, ebs.map { |b| b.blueprint.bindings.embed_bindings_for(runtime) }].flatten.compact.uniq
    end

    def shallow_embed_bindings_for(runtime)
      embed_bindings.select { |t| t.for_runtime?(runtime) }
    end

    def connect_bindings
      all.reject(&:embed?)
    end

    def deep_bindings
      all.map(&:deep_bindings).flatten.uniq
    end

    def tree_paths(previous = OpenStruct.new(identifiers: [context_identifier]))
      [any? ? map { |b| b.tree_path_with(previous) } : previous].flatten
    end

    def descriptors
      all.map(&:descriptor).compact
    end

    def emission_type; emission.qualifier ;end

    def method_missing(m, *args, &block); named(m) || super ;end
    def respond_to_missing?(m, *); named(m) || super ;end

  end
end
