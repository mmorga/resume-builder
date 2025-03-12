# frozen_string_literal: true

require "date"
require "yaml"

require "partial"

module ResumeYaml
  autoload(:YamlMapping, "resume_yaml/yaml_mapping.rb")
end

Dir["#{__dir__}/resume_yaml/*.rb"].map { |f| File.join("resume_yaml", File.basename(f, ".rb")) }.each do |file|
  require file
end
