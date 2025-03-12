# frozen_string_literal: true

module ResumeYaml
  class PostalAddress
    include YamlMapping

    yaml_attr :post_office_box_number
    yaml_attr :street_address
    yaml_attr :address_locality
    yaml_attr :address_region
    yaml_attr :postal_code
    yaml_attr :address_country

    def locality_region
      [address_locality, address_region].join(", ")
    end

    def to_json_ld
      return nil if instance_variables_blank?

      {
        "@type" => "PostalAddress",
        "streetAddress" => street_address,
        "addressLocality" => address_locality,
        "addressRegion" => address_region,
        "addressCountry" => address_country,
        "postalCode" => postal_code
      }.compact
    end
  end
end
