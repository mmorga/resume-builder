# frozen_string_literal: true

class Integer
  def to_yaml_ast
    Psych::Nodes::Scalar.new(to_s)
  end

  def to_json_ld
    to_i
  end
end

class String
  def to_yaml_ast
    Psych::Nodes::Scalar.new(to_s)
  end

  def to_json_ld
    empty? ? nil : to_s
  end
end

class NilClass
  def to_yaml_ast
    Psych::Nodes::Scalar.new("")
  end

  def to_json_ld
    nil
  end
end

class Array
  def to_yaml_ast
    seq = Psych::Nodes::Sequence.new
    each do |o|
      seq.children << o.to_yaml_ast
    end
    seq
  end

  def to_json_ld
    return nil if empty?

    ary = map(&:to_json_ld).compact

    ary.empty? ? nil : ary
  end
end

class Hash
  def to_yaml_ast
    mapping = Psych::Nodes::Mapping.new
    each do |k, v|
      mapping.children << k.to_yaml_ast
      mapping.children << v.to_yaml_ast
    end
    mapping
  end

  def to_json_ld
    return nil if empty?

    hash = transform_values(&:to_json_ld).compact

    hash.empty? ? nil : hash
  end
end
