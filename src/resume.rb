# frozen_string_literal: true

require_relative "data"
require_relative "meta"
require_relative "partial"
require_relative "style"
require_relative "unordered_list"

def build_resume(yaml_file, template_file, out_html)
  resume = Partial.new(template_file, load_resume_yaml(yaml_file))
  File.write(out_html, resume.result)
end
