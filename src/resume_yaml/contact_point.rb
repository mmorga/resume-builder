# frozen_string_literal: true

module ResumeYaml
  class ContactPoint
    include YamlMapping

    yaml_attr :contact_type
    yaml_attr :identifier
    yaml_attr :image
    yaml_attr :url

    def to_json_ld
      return nil if instance_variables_blank?

      {
        "@type" => "ContactPoint",
        "contactType" => contact_type,
        "identifier" => identifier,
        "image" => image,
        "url" => url
      }.compact
    end
  end
end
