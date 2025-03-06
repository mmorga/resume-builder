# frozen_string_literal: true

require "date"
require "yaml"

require "partial"

module ResumeYaml
  autoload(:AggregateRating, "resume_yaml/aggregate_rating.rb")
  autoload(:ContactPoint, "resume_yaml/contact_point.rb")
  autoload(:Degree, "resume_yaml/degree.rb")
  autoload(:Education, "resume_yaml/education.rb")
  autoload(:History, "resume_yaml/history.rb")
  autoload(:Job, "resume_yaml/job.rb")
  autoload(:Meta, "resume_yaml/meta.rb")
  autoload(:Occupation, "resume_yaml/occupation.rb")
  autoload(:Resume, "resume_yaml/resume.rb")
  autoload(:Skills, "resume_yaml/skills.rb")
  autoload(:Summary, "resume_yaml/summary.rb")
  autoload(:Title, "resume_yaml/title.rb")
  autoload(:Twitter, "resume_yaml/twitter.rb")
  autoload(:YamlMapping, "resume_yaml/yaml_mapping.rb")
  autoload(:WorksFor, "resume_yaml/works_for.rb")
end
