# frozen_string_literal: true

module ResumeYaml
  class Degree
    include YamlMapping

    yaml_attr :education_level
    yaml_attr :field
    yaml_attr :year
    yaml_attr :school
    yaml_attr :location
    yaml_attr :department
    yaml_attr :url
    yaml_attr :description
    yaml_attr(:aggregate_rating) { |obj| AggregateRating.from_hash(obj) }
    yaml_attr :credential_category
    yaml_attr :date_created

    def to_json_ld
      return nil if instance_variables_blank?

      {
        "@type" => "EducationalOccupationalCredential",
        "aggregateRating" => aggregate_rating&.to_json_ld,
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
