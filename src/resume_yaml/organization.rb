# frozen_string_literal: true

module ResumeYaml
  class Organization
    include YamlMapping

    yaml_attr :title
    yaml_attr :name
    yaml_attr :location
    yaml_attr :start_date
    yaml_attr :end_date
    yaml_attr(:content) { |con| default_array(con) }
    yaml_attr :same_as

    def to_json_ld(employee_same_as = nil)
      return nil if instance_variables_blank?

      {
        "@type" => "Organization",
        "name" => name,
        "sameAs" => same_as,
        "employee" => Person.from_hash(
          "occupation" => { "role_name" => title, "start_date" => start_date, "end_date" => end_date },
          "same_as" => employee_same_as
        ).to_json_ld
      }.compact
    end
  end
end
