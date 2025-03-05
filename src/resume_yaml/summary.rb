# frozen_string_literal: true

module ResumeYaml
  class Summary
    include YamlMapping

    attr_reader :title, :content

    output_yaml_order :title, :content

    def title=(str)
      @title = default_string(str, "Summary")
    end

    def content=(con)
      @content = default_array(con)
    end
  end
end
