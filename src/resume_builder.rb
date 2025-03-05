# frozen_string_literal: true

$LOAD_PATH.unshift __dir__

require "partial"
require "resume_yaml"

class ResumeTemplate < Partial; end

def load_resume(yaml_file)
  ResumeYaml::Resume.from_hash(YAML.load_file(yaml_file))
end

def build_resume(yaml_file, template_file, out_html)
  resume = ResumeTemplate.new(template_file, load_resume(yaml_file))
  File.write(out_html, resume.result)
end
