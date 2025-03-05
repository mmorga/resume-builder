# frozen_string_literal: true

require "date"
require "yaml"

require "partial"

module ResumeYaml
  autoload(:Degree, "resume_yaml/degree.rb")
  autoload(:Education, "resume_yaml/education.rb")
  autoload(:History, "resume_yaml/history.rb")
  autoload(:Job, "resume_yaml/job.rb")
  autoload(:Meta, "resume_yaml/meta.rb")
  autoload(:Resume, "resume_yaml/resume.rb")
  autoload(:Skills, "resume_yaml/skills.rb")
  autoload(:Summary, "resume_yaml/summary.rb")
  autoload(:Title, "resume_yaml/title.rb")
  autoload(:Twitter, "resume_yaml/twitter.rb")
  autoload(:YamlMapping, "resume_yaml/yaml_mapping.rb")
end
