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

    def json_ld
      return nil if instance_variables_nil?

      {
        "@type" => "EducationalOccupationalCredential",
        "aggregateRating" => aggregate_rating&.json_ld,
        "credentialCategory" => credential_category,
        "educationalLevel" => education_level,
        "dateCreated" => date_created,
        "about" => degree_about,
        "recognizedBy" => degree_recognized_by
      }.compact
    end

    def degree_about
      return nil if department.nil?

      {
        "@type" => "EducationalOccupationalProgram",
        "name" => department
      }
    end

    def degree_recognized_by
      return nil if [school, url].all? { |f| f.nil? || f.empty? }

      {
        "@type" => "CollegeOrUniversity",
        "name" => school,
        "sameAs" => url
      }
    end
  end
end
