# frozen_string_literal: true

module ResumeYaml
  class WorksFor
    include YamlMapping

    attr_accessor :name, :same_as

    output_yaml_order :name, :same_as
  end
end
