# frozen_string_literal: true

module ResumeYaml
  class Resume
    include YamlMapping

    yaml_attr(:meta) { |hash| Meta.from_hash(hash) }
    yaml_attr(:person) { |hash| Person.from_hash(hash) }

    def to_yaml
      stream = Psych::Nodes::Stream.new
      doc    = Psych::Nodes::Document.new
      stream.children << doc
      doc.children    << to_yaml_ast
      stream.to_yaml
    end
  end
end
