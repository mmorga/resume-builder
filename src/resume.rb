# frozen_string_literal: true

require "data_block"
require "date"
require "degree"
require "education"
require "history"
require "job"
require "meta"
require "partial"
require "skills"
require "summary"
require "title"
require "twitter"
require "yaml"
require "yaml_order"

class Resume < DataBlock
  attr_reader :meta, :title, :summary, :history, :skills, :education

  extend YamlOrder

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

class ResumeTemplate < Partial; end

def build_resume(yaml_file, template_file, out_html)
  resume = ResumeTemplate.new(template_file, Resume.from_hash(YAML.load_file(yaml_file)))
  File.write(out_html, resume.result)
end
