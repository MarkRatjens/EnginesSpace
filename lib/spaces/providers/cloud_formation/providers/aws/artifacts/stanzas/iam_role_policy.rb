require_relative 'resource'

module Artifacts
  module CloudFormation
    module Aws
      class IamRolePolicyStanza < ResourceStanza
        include Named

        class << self
          def default_configuration =
            super.merge(
              role_binding: :'iam-role'
            )
        end

        def more_snippets =
          {
            role: "aws_iam_role.#{qualification_for(:role_binding)}.id",

            policy: {
              Version: "2012-10-17",
              Statement: [
                {
                  Action: [
                    "ec2:Describe*"
                  ],
                  Effect: "Allow",
                  Resource: "*"
                }
              ]
            }
          }

        def tags_snippet = nil

      end
    end
  end
end