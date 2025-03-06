# frozen_string_literal: true

module ResumeYaml
  class Degree
    include YamlMapping

    attr_accessor :education_level, :field, :year, :school, :location, :department, :url,
                  :description, :credential_category, :date_created
    attr_reader :aggregate_rating

    output_yaml_order :education_level, :field, :year, :school, :location, :department, :url,
                      :description, :aggregate_rating, :credential_category, :date_created

    def aggregate_rating=(obj)
      @aggregate_rating = AggregateRating.from_hash(obj)
    end
  end
end
