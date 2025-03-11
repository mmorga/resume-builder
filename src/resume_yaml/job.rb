# frozen_string_literal: true

module ResumeYaml
  class Job
    include YamlMapping

    yaml_attr :title
    yaml_attr :company
    yaml_attr :url
    yaml_attr :location
    yaml_attr :start_date
    yaml_attr :end_date
    yaml_attr(:content) { |con| default_array(con) }

    def json_ld(employee_same_as = nil)
      {
        "@type" => "Organization",
        "name" => company,
        "sameAs" => url,
        "employee" => {
          "@type" => "Person",
          "hasOccupation" => {
            "@type" => "EmployeeRole",
            "roleName" => title,
            "startDate" => start_date,
            "endDate" => end_date
          }.compact,
          "sameAs" => employee_same_as
        }.compact
      }.compact
    end
  end
end
