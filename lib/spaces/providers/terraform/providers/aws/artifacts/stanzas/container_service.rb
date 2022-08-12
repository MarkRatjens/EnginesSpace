require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class ContainerServiceStanza < CapsuleStanza
        include Named
        include TaskDefining

        class << self
          def default_configuration =
            super.merge(
              cluster_binding: :'container-service-cluster',
              # iam_role_binding: :'iam-role',
              desired_count: 3,
              launch_type: :'FARGATE'
            )

          def launch_type = default_configuration.launch_type
        end

        def default_configuration =
          super.merge(
            task_definition_binding: default_binding,
            target_group_binding: default_binding,
            load_balancer_binding: default_binding,
            listener_binding: default_binding
          )

        def more_snippets =
          # REMOVED ...
          # cluster = aws_ecs_cluster.#{arena_attachable_qualification_for(:cluster_binding)}.id
          # is this right?
          %(
            depends_on = [
              aws_lb.#{arena_attachable_qualification_for(:load_balancer_binding)},
              aws_lb_listener.#{arena_attachable_qualification_for(:listener_binding)}
            ]

            cluster = aws_ecs_cluster.#{arena_attachable_qualification_for(:cluster_binding)}.id
            task_definition = aws_ecs_task_definition.#{arena_attachable_qualification_for(:task_definition_binding)}.arn
            ordered_placement_strategy {
              type  = "binpack"
              field = "cpu"
            }
            load_balancer {
              target_group_arn = aws_lb_target_group.#{arena_attachable_qualification_for(:target_group_binding)}.arn
              container_name   = "#{application_identifier}"
              container_port   = "#{ports.first.container_port}"
            }
          )

        def configuration_hash =
          super.without(:cluster_binding, :task_definition_binding, :target_group_binding, :load_balancer_binding, :listener_binding)
          # super.without(:cluster_binding, :iam_role_binding, :task_definition_binding, :target_group_binding)

      end
    end
  end
end
