require_relative '../texts/file_text'
require_relative 'emission'
require_relative 'providers/provider'

module Provisioning
  class Provisions < Emission

    class << self
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :stanzas

    delegate(dns: :universe)

    def dns_default
      dns.default.tap do |m|
        m.emission = self
      end
    end

    def all(division_identifier)
      resolutions_with(division_identifier).map { |r| r.send(division_identifier).all }.flatten.compact
    end

    def resolutions_with(division_identifier)
      resolutions.select { |r| r.has?(division_identifier) }
    end

    def resolutions; universe.resolutions.all ;end

    def providers
      [all(:providers), providers_implied_in_containers].flatten.uniq(&:uniqueness)
    end

    def providers_implied_in_containers
      all(:containers).map do |b|
        universe.provisioning.providers.by(struct: b.struct, division: self)
      end
    end

    def auxiliary_texts; files_for(:modules) ;end

    def files_for(directory)
      target_file_names_for(directory).map do |t|
        text_class.new(origin: t, directory: directory, division: self)
      end
    end

    def target_file_names_for(directory)
      Dir[target_directory_for(directory)].reject { |f| ::File.directory?(f) }
    end

    def target_directory_for(directory)
      File.join(File.dirname(__FILE__), "target/#{directory}/**/*")
    end

    def text_class; Texts::FileText ;end

    def file_name; identifier ;end

    def initialize(descriptor)
      self.struct = OpenStruct.new
      self.struct.descriptor = descriptor&.emit if descriptor
    end

  end
end
