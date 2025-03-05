# frozen_string_literal: true

require "partial"
require "resume_yaml"

class ResumeTemplate < Partial; end

def build_resume(yaml_file, template_file, out_html)
  resume = ResumeTemplate.new(template_file, ResumeYaml::Resume.from_hash(YAML.load_file(yaml_file)))
  File.write(out_html, resume.result)
end
