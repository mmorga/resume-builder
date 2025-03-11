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

    def json_ld
      return nil if content.nil? || content.empty?

      return content if content.is_a?(Array)

      content.map do |k, v|
        {
          "@type" => "DefinedTerm",
          "name" => k,
          "description" => v
        }.compact
      end
    end
  end
end
