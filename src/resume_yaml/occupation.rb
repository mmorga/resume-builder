# frozen_string_literal: true

module ResumeYaml
  class Occupation
    include YamlMapping

    attr_accessor :role_name, :start_date

    output_yaml_order :role_name, :start_date
  end
end
