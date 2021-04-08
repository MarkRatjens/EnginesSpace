module Arenas
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Arena
      end
    end

    delegate([:resolutions, :provisioning] => :universe)

    def save_bootstrap_resolutions_for(model)
      model.resolutions.map { |r| resolutions.save(r) }
    end

    def save_bootstrap_provisionings_for(model)
      model.provisioned.map { |p| provisioning.save(p) }
    end

    def save(model)
      super.tap do
        artifact_file_name_for(model).write(model.artifact)
      end
    end

    def save_initial(model)
      initial_file_name_for(model).write(model.initial_artifact)
    end

    def artifact_file_name_for(model)
      path_for(model).join("_arena.#{artifact_extension}")
    end

    def initial_file_name_for(model)
      path_for(model).join("_initial.#{artifact_extension}")
    end

    def path_for(model)
      path.join(model.arena.context_identifier)
    end

    def artifact_extension; :tf ;end

  end
end
