# frozen_string_literal: true

require "yaml"

def structify(val)
  case val
  when Hash
    cls = Struct.new(*val.keys)
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
