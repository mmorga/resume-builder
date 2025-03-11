# frozen_string_literal: true

module ResumeYaml
  class Organization
    include YamlMapping

    yaml_attr :name
    yaml_attr :same_as

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
