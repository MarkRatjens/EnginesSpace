module Emissions
  module Targeting

    def turtles; turtle_targets.map(&:blueprint) ;end
    def turtle_targets; targets(:turtle_targets) ;end

    def connections_down; connect_targets.map { |t| t.resolution_in(arena) } ;end
    def connect_targets; targets(:connect_targets) ;end

    def embeds_down; embed_targets.map(&:blueprint) ;end
    def embed_targets; targets(:embed_targets) ;end

    def targets(type); bindings.send(type).uniq(&:uniqueness) ;end

  end
end
