module Artifacts
  module Content

    # TODO: as providers have the own quirks about
    # content generation and may offer offer choices,
    # the ultimate format should be customisable in arenas
    # Choices so far:
    # => DOCKER - command-line-style text
    # => PACKER (deprecated) - JSON from hashes
    # => TERRAFORM - HCL in text
    # => CLOUD FORMATION - JSON or YAML from hashes

    def text_content = array_content.join("\n")

    def yaml_content = YAML.dump(hash_content.no_symbols)
    def json_content = hash_content.no_symbols.to_json

    def hash_content
      [snippets].flatten.inject({}) do |m, s|
        m.merge(s)
      end
    end

    def array_content = [snippets].flatten.values

  end
end
