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
    when Integer
      Psych::Nodes::Scalar.new(obj.to_s)
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
