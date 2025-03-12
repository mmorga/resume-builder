# frozen_string_literal: true

module ResumeYaml
  class EmployeeRole
    include YamlMapping

    yaml_attr :role_name
    yaml_attr :start_date
    yaml_attr :end_date

    def to_json_ld
      return nil if instance_variables_blank?

      {
        "@type" => "EmployeeRole",
        "roleName" => role_name,
        "startDate" => start_date,
        "endDate" => end_date
      }.compact
    end
  end
end
