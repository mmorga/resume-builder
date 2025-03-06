# frozen_string_literal: true

module ResumeYaml
  class AggregateRating
    include YamlMapping

    attr_accessor :rating_value, :name

    output_yaml_order :rating_value, :name
  end
end
