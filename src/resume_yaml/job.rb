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
  end
end
