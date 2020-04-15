require_relative '../docker/images/space'

module Images
  class Space < ::Spaces::Space

    delegate(all: :bridge)

    def by(descriptor)
      bridge.get(descriptor.identifier)
    end

    def save(subject)
      subject.product.map do |t|
        save_text(t)
        "#{t.product_path}"
      end
    end

    def from_subject(subject)
      bridge.from_directory(path_for(subject))
    end

    def from_tar(subject)
      bridge.from_tar(path_for(subject))
    end

    def bridge
      @bridge ||= Docker::Images::Space.new
    end

  end
end
