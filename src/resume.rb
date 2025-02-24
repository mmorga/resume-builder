# frozen_string_literal: true

require "erb"
require "yaml"

class Resume
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  def initialize(hash)
    @resume = structify(hash)
  end

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

  def special_format(str)
    if str =~ EMAIL_REGEX
      "<a href=\"mailto:#{str}\">#{str}</a>"
    else
      str
    end
  end

  def title
    @resume.title
  end

  def meta
    @resume.meta
  end

  def summary
    @resume.summary
  end

  def history
    @resume.history
  end

  def skills
    @resume.skills
  end

  def education
    @resume.education
  end

  def nested_list_template
    @nested_list_template ||= File.read("src/nested-list.html.erb")
  end

  def nested_list(ary)
    template = ERB.new(nested_list_template, trim_mode: '%<>')
    context = NestedListContext.new(self, ary)
    template.result(context.get_binding)
  end
end

class NestedListContext
  attr_reader :ary

  def initialize(resume, ary)
    @resume = resume
    @ary = ary
  end

  def named_nested_list(list)
    @resume.nested_list(list)
  end

  def get_binding
    binding
  end
end

def build_resume(yaml_file, template_erb, out_html)
  template = ERB.new(File.read(template_erb), trim_mode: '%<>')
  resume = Resume.new(YAML.load_file(yaml_file, symbolize_names: true))
  File.write(out_html, template.result(resume.instance_eval { binding }))
end
