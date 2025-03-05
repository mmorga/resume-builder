# frozen_string_literal: true

module ResumeYaml
  class Title
    include YamlMapping

    attr_accessor :name
    attr_reader :address

    output_yaml_order :name, :address

    def address=(addr)
      @address = default_array(addr)
    end
  end
end
