# frozen_string_literal: true

module ResumeYaml
  class EmployeeRole
    include YamlMapping

    attr_accessor :role_name, :start_date

    output_yaml_order :role_name, :start_date

    def json_ld
      return nil if instance_variables_nil?

      {
        "@type" => "EmployeeRole",
        "roleName" => occupation.role_name,
        "startDate" => occupation.start_date
      }.compact
    end
  end
end
