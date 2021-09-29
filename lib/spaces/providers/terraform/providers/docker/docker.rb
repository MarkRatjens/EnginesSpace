module Providers
  module Terraform
    module Docker
      class Docker < ::ProviderAspects::Provider

        def provider_stanzas
          %(
            provider "#{type}" {
              # Note need to expand this to support remote hosts
              host = "unix:///var/run/docker.sock"
            }
          )
        end

        def required_stanza
          %(
            docker = {
              version = "#{configuration.version}"
              source = "#{configuration.source}"
            }
          )
        end

      end
    end
  end
end
