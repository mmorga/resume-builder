# frozen_string_literal: true

module ResumeYaml
  class Resume
    include YamlMapping
    attr_reader :meta, :title, :summary, :history, :skills, :education

    output_yaml_order :meta, :title, :summary, :history, :skills, :education

    def meta=(hash)
      @meta = Meta.from_hash(hash)
    end

    def title=(hash)
      @title = Title.from_hash(hash)
    end

    def summary=(hash)
      @summary = Summary.from_hash(hash)
    end

    def history=(hash)
      @history = History.from_hash(hash)
    end

    def skills=(hash)
      @skills = Skills.from_hash(hash)
    end

    def education=(hash)
      @education = Education.from_hash(hash)
    end

    def to_yaml
      stream = Psych::Nodes::Stream.new
      doc    = Psych::Nodes::Document.new
      stream.children << doc
      doc.children    << to_yaml_ast
      stream.to_yaml
    end
  end
end
