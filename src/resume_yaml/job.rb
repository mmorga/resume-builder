# frozen_string_literal: true

module ResumeYaml
  class Job
    include YamlMapping
    attr_accessor :title, :company, :location, :dates
    attr_reader :content

    output_yaml_order :title, :company, :location, :dates, :content

    def content=(con)
      @content = default_array(con)
    end
  end
end
