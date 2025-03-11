# frozen_string_literal: true

module ResumeYaml
  class Job
    include YamlMapping

    attr_accessor :title, :company, :location, :url, :start_date, :end_date
    attr_reader :content

    output_yaml_order :title, :company, :url, :location, :start_date, :end_date, :content

    def content=(con)
      @content = default_array(con)
    end

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
