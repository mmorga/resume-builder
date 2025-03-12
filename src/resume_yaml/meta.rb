# frozen_string_literal: true

module ResumeYaml
  class Meta
    include YamlMapping

    yaml_attr :created
    yaml_attr :keywords
    yaml_attr :author
    yaml_attr :copyright
    yaml_attr :license
    yaml_attr :canonical_link
    yaml_attr :pdf_link
    yaml_attr(:twitter) { |obj| Twitter.from_hash(obj) }
  end
end
