module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class Hash < ::Artifacts::Format

          def runtime_qualifier = name_elements[2]

          def content =
            {
              "#{resource_identifier}":
                all_the_snippets.inject({type: resource_type}) do |m, s|
                    m.merge(s || {})
                  end
            }.deep(:camelize, of: :keys)

          def resource_identifier = super.underscore.camelize

          def resource_type =
            "#{runtime_qualifier.upcase}_#{super}".amazonize

          def all_the_snippets =
            [
              name_snippet,
              dependency_snippet,
              configuration_snippet,
              tags_snippet
            ].compact

          def name_snippet =
            {name: resource_identifier}

          def dependency_snippet = {}

          def configuration_snippet =
            {
              properties: configuration_hash.without(:tags).merge(more_snippets)
            }

          def tags_snippet =
            {tags: tags_hash}

          def tags_hash =
            {
              name: resource_identifier,
              environment: 'var.app_environment'
            }.merge(configuration_hash[:tags] || {})

          def more_snippets = {}

        end
      end
    end
  end
end
