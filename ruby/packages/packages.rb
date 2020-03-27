require_relative '../installations/division'
require_relative 'package'

module Packages
  class Packages < ::Installations::Division

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@packages_step_precedence ||= { late: [:run_scripts] }
      end
    end

    def all
      @all ||= installation.struct.packages.map { |s| package_class.new(struct: s, context: self) }
    end

    def scripts
      all.map(&:scripts).flatten.uniq(&:uniqueness)
    end

    def build_script_path
      "#{super}/packages"
    end

    def package_class
      Package
    end

  end
end
