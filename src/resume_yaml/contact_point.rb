# frozen_string_literal: true

module ResumeYaml
  class ContactPoint
    include YamlMapping

    attr_accessor :contact_type, :identifier, :image, :url

    output_yaml_order :contact_type, :identifier, :image, :url
  end
end
