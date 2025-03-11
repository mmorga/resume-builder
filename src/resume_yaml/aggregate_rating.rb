# frozen_string_literal: true

module ResumeYaml
  class AggregateRating
    include YamlMapping

    yaml_attr :rating_value
    yaml_attr :name

    def json_ld
      return nil if instance_variables_nil?

      {
        "@type" => "AggregateRating",
        "ratingValue" => rating_value,
        "name" => name
      }.compact
    end
  end
end
