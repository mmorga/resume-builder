# frozen_string_literal: true

module ResumeYaml
  class Degree
    include YamlMapping

    attr_accessor :degree, :field, :year, :school, :location, :department, :url, :description

    output_yaml_order :degree, :field, :year, :school, :location, :department, :url, :description
  end
end
