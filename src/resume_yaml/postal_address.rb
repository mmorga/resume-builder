# frozen_string_literal: true

module ResumeYaml
  class PostalAddress
    include YamlMapping

    attr_accessor :post_office_box_number, :street_address, :address_locality,
                  :address_region, :postal_code, :address_country

    output_yaml_order :post_office_box_number, :street_address, :address_locality,
                      :address_region, :postal_code, :address_country

    def json_ld
      return nil if [post_office_box_number, street_address, address_locality, address_region, postal_code,
                     address_country].all?(&:nil?)

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
