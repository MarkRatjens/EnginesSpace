require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class LoadBalancerTargetGroupStanza < ResourceStanza
		def configuration_snippet
			%(
             vpc_id = aws_vpc.#{vpc.application_identifier}.id
			 subnets         = aws_subnet.public.*.id
  			 security_groups = [aws_security_group.lb.id]
             protocol = #{configuration.protocol}
             port = #{configuration.port}
            )
		end
        def more_snippets
          %(
			
            health_check {
              healthy_threshold   = #{configuration.healthy_threshold}
              interval            = #{configuration.interval}
              protocol            = #{configuration.protocol}
              matcher             = #{configuration.matcher}
              timeout             = #{configuration.timeout}
              path                = #{configuration.health_check_path}
              unhealthy_threshold = #{configuration.unhealthy_threshold}
            }
          )
        end
        def default_configuration
          OpenStruct.new(
            description: application_identifier,
				target_type: "ip",
				healthy_threshold: 3,		
      			interval: 300,
      			protocol: 'HTTP',
      			matcher: 200,
      			timeout: 3,
				unhealthy_threshold: 2,
				health_check_path: '/',				
			    path_pattern:  ["/*"]
          )
        end
      end
    end
  end
end
