# frozen_string_literal: true

module ResumeYaml
  class Demand
    include YamlMapping

    yaml_attr :description
    yaml_attr :availability_starts
    yaml_attr :availability_ends
    yaml_attr :available_at_or_from
    yaml_attr :delivery_lead_time

    def json_ld
      return nil if instance_variables_nil?

      {
        '@type': "Demand",
        description: description,
        availabilityStarts: availability_starts,
        availabilityEnds: availability_ends,
        availableAtOrFrom: available_at_or_from,
        # TODO
        # {
        #     "address": {
        #         "@type": "PostalAddress",
        #         "@id": "_:9145a8c7-6535-40b3-8683-7445b07734ab_availableAtOrFrom_address",
        #         "addressLocality": "Texas",
        #         "addressCountry": "YTexas, USA"
        #     },
        #     "@type": "Place",
        #     "@id": "_:9145a8c7-6535-40b3-8683-7445b07734ab_availableAtOrFrom"
        # },
        deliveryLeadTime: delivery_lead_time
      }.compact
    end
  end
end
