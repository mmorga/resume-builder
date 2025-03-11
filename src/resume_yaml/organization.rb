# frozen_string_literal: true

module ResumeYaml
  class Organization
    include YamlMapping

    attr_accessor :name, :same_as

    output_yaml_order :name, :same_as

    def json_ld
      return nil if instance_variables_nil?

      {
        "@type" => "Organization",
        "name" => name,
        "sameAs" => same_as
      }.compact
    end
  end
end
