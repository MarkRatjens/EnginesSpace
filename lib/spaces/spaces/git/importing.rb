require 'git'

module Spaces
  module Git
    module Importing

      def by_import(force:)
        if space.imported?(descriptor) && remote_current?
          pull_remote if force
        else
          space.exist_then_delete(descriptor)
          clone_remote
        end

        space.by(descriptor)
      end

      def pull_remote
        opened.pull(remote_name, branch_name)
      rescue git_error => e
        raise_failure_for(e)
      end

      def clone_remote
        git.clone(repository_url, identifier, branch: branch_name, path: space.path, depth: 0)
      rescue git_error => e
        raise_failure_for(e)
      end

    end
  end
end
