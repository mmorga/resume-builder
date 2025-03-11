# frozen_string_literal: true

module ResumeYaml
  class Meta
    include YamlMapping

    attr_accessor :keywords, :author, :copyright, :license,
                  :canonical_link, :pdf_link, :created
    attr_reader :twitter

    output_yaml_order :created, :keywords, :author, :copyright, :license,
                      :canonical_link, :pdf_link, :twitter

    def twitter=(obj)
      @twitter = Twitter.from_hash(obj)
    end
  end
end
