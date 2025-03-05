# frozen_string_literal: true

module ResumeYaml
  class Education
    include YamlMapping
    attr_reader :title, :degrees

    output_yaml_order :title, :degrees

    def title=(str)
      @title = default_string(str, "Education")
    end

    def degrees=(deg)
      @degrees = default_array(deg).map { |d| Degree.from_hash(d) }
    end
  end
end
