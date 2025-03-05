# frozen_string_literal: true

require "date"
require "yaml"

class DataBlock
  def self.from_hash(hash)
    new(hash || {})
  end

  def initialize(hash)
    public_methods(false)
      .select { |sym| sym.to_s.end_with?("=") }
      .each { |sym| send(sym, hash[sym.to_s[..-2]]) }
  end

  def deep_hash(val)
    case val
    when DataBlock
      val.to_hash
    when Array
      val.map { |i| deep_hash(i) }
    when Hash
      val.transform_values { |i| deep_hash(i) }
    else
      val
    end
  end

  def to_hash
    instance_variables.each_with_object({}) do |sym, hash|
      hash[sym.to_s[1..]] = deep_hash(instance_variable_get(sym))
    end
  end

  def yaml_ast_of_array(obj)
    seq = Psych::Nodes::Sequence.new
    obj.each do |o|
      seq.children << yaml_ast_of(o)
    end
    seq
  end

  def yaml_ast_of_hash(obj)
    mapping = Psych::Nodes::Mapping.new
    obj.each do |k, v|
      mapping.children << yaml_ast_of(k)
      mapping.children << yaml_ast_of(v)
    end
    mapping
  end

  def yaml_ast_of(obj)
    case obj
    when String, NilClass
      Psych::Nodes::Scalar.new(obj || "")
    when DataBlock
      obj.to_yaml_ast
    when Array
      yaml_ast_of_array(obj)
    when Hash
      yaml_ast_of_hash(obj)
    else
      raise "Need to handle #{obj.class}\n#{obj.inspect}\n"
    end
  end

  def to_yaml_ast
    mapping = Psych::Nodes::Mapping.new
    self.class.yaml_order.each do |sym|
      mapping.children << Psych::Nodes::Scalar.new(sym.to_s)
      mapping.children << yaml_ast_of(send(sym))
    end
    mapping
  end

  def blank?(str)
    str.nil? || str.empty?
  end

  def default_array(ary)
    blank?(ary) ? [] : Array(ary)
  end

  def default_hash_or_array(hoa)
    return {} if blank?(hoa)

    hoa
  end

  def default_string(str, default)
    blank?(str) ? default : str
  end
end

module YamlOrder
  def output_yaml_order(*attrs)
    @yaml_order = attrs
  end

  def yaml_order
    @yaml_order || instance_variables
  end
end

class Twitter < DataBlock
  attr_accessor :card, :site, :creator, :domain, :description, :title, :image

  extend YamlOrder

  output_yaml_order :card, :site, :creator, :domain, :description, :title, :image
end

class Meta < DataBlock
  attr_accessor :description, :keywords, :author, :copyright, :license,
                :canonical_link, :pdf_link, :created
  attr_reader :twitter

  extend YamlOrder

  output_yaml_order :description, :keywords, :author, :copyright, :license, :canonical_link, :pdf_link, :twitter

  def twitter=(obj)
    @twitter = Twitter.from_hash(obj)
  end
end

class Title < DataBlock
  attr_accessor :name
  attr_reader :address

  extend YamlOrder

  output_yaml_order :name, :address

  def address=(addr)
    @address = default_array(addr)
  end
end

class Summary < DataBlock
  attr_reader :title, :content

  extend YamlOrder

  output_yaml_order :title, :content

  def title=(str)
    @title = default_string(str, "Summary")
  end

  def content=(con)
    @content = default_array(con)
  end
end

class Job < DataBlock
  attr_accessor :title, :company, :location, :dates
  attr_reader :content

  extend YamlOrder

  output_yaml_order :title, :company, :location, :dates, :content

  def content=(con)
    @content = default_array(con)
  end
end

class History < DataBlock
  attr_reader :title, :jobs

  extend YamlOrder

  output_yaml_order :title, :jobs

  def title=(str)
    @title = default_string(str, "Experience")
  end

  def jobs=(job_list)
    @jobs = default_array(job_list).map { |j| Job.from_hash(j) }
  end
end

class Skills < DataBlock
  attr_reader :title, :content

  extend YamlOrder

  output_yaml_order :title, :content

  def title=(str)
    @title = default_string(str, "Skills")
  end

  def content=(con)
    @content = default_hash_or_array(con)
  end
end

class Degree < DataBlock
  attr_accessor :degree, :field, :year, :school, :location

  extend YamlOrder

  output_yaml_order :degree, :field, :year, :school, :location
end

class Education < DataBlock
  attr_reader :title, :degrees

  extend YamlOrder

  output_yaml_order :title, :degrees

  def title=(str)
    @title = default_string(str, "Education")
  end

  def degrees=(deg)
    @degrees = default_array(deg).map { |d| Degree.from_hash(d) }
  end
end

class ResumeData < DataBlock
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

def load_resume_yaml(yaml_file)
  ResumeData.from_hash(YAML.load_file(yaml_file))
end
