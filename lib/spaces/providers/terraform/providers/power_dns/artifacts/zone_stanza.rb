module Artifacts
  module Terraform
    module PowerDns
      class ZoneStanza < ::Artifacts::Stanza

        def snippets
          %(
            resource "#{dns_qualifier}_zone" "#{arena.identifier}-zone" {
              name        = "#{arena.identifier}.#{universe.host}."
              kind        = "native"
              nameservers = [#{dns_address}]
            }
          )
        end

        def dns_address
          "#{container_type}.#{dns_qualifier}.ipv4_address"
        end

        def dns_qualifier
          provider.dns_qualifier.camelize.downcase
        end

      end
    end
  end
end