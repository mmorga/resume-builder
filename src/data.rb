# frozen_string_literal: true

require "yaml"

class MyStruct < Struct
  def method_missing(symbol, ...)
    send(symbol, ...) if members.include?(symbol)
  end

  def respond_to_missing?(_, _)
    true
  end
end

def structify(val)
  case val
  when Hash
    cls = MyStruct.new(*val.keys)
    cls.new(*val.values.map { |v| structify(v) })
  when Array
    val.map { |i| structify(i) }
  else
    val
  end
end

def load_resume_yaml(yaml_file)
  structify(YAML.load_file(yaml_file, symbolize_names: true))
end
