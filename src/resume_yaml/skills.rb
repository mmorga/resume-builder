# frozen_string_literal: true

module ResumeYaml
  class Skills
    include YamlMapping
    attr_reader :title, :content

    output_yaml_order :title, :content

    def title=(str)
      @title = default_string(str, "Skills")
    end

    def content=(con)
      @content = default_hash_or_array(con)
    end
  end
end
