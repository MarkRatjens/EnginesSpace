require_relative '../../blueprints/tensor'
require_relative '../../products/product'
require_relative 'collaboration'

module Docker
  module Files
    class File < ::Products::Product
      include Collaboration

      Dir["#{__dir__}/steps/*"].each { |f| require f }

      class << self
        def collaboration_precedence
          @@collaboration_precedence ||= [:framework, :environment, :domain, :dependencies, :os_packages, :nodules, :packages, :docker_file]
        end

        def step_group_precedence
          @@step_group_precedence ||= [:first, :early, :anywhere, :late, :last]
        end

        def step_precedence
          @@docker_file_step_precedence ||= {
            early: [:adds],
            late: [:preparations, :permissions, :templates, :source_protection, :seeds, :data_persistence, :installs, :source_persistence],
            last: [:final]
          }
        end
      end

      def collaboration_precedence
        self.class.collaboration_precedence
      end

      def step_group_precedence
        self.class.step_group_precedence
      end

      def content
        layers.flatten.compact.join("\n")
      end

      def layers
        step_group_precedence.map do |g|
          collaboration_precedence.map do |c|
            tensor.send(c).layers_for(g)
          end
        end
      end

      def layers
        step_group_precedence.map do |g|
          collaborators.map { |c| c.layers_for(g) }
        end
      end

      def collaborators
        collaboration_precedence.map { |c| tensor.send(c) }.compact
      end

      def file_path
        "#{identifier}/DockerFile"
      end

    end
  end
end
