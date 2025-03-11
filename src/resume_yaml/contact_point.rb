# frozen_string_literal: true

module ResumeYaml
  class ContactPoint
    include YamlMapping

    attr_accessor :contact_type, :identifier, :image, :url

    output_yaml_order :contact_type, :identifier, :image, :url

    def json_ld
      return nil if [contact_type, identifier, image, url].all?(&:nil?)

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
