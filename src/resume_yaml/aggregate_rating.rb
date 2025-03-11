# frozen_string_literal: true

module ResumeYaml
  class AggregateRating
    include YamlMapping

    attr_accessor :rating_value, :name

    output_yaml_order :rating_value, :name

    def json_ld
      return nil if [rating_value, name].all?(&:nil?)

      {
        "@type" => "AggregateRating",
        "ratingValue" => rating_value,
        "name" => name
      }.compact
    end
  end
end
