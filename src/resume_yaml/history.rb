# frozen_string_literal: true

module ResumeYaml
  class History
    include YamlMapping

    attr_reader :title, :jobs

    output_yaml_order :title, :jobs

    def title=(str)
      @title = default_string(str, "Experience")
    end

    def jobs=(job_list)
      @jobs = default_array(job_list).map { |j| Job.from_hash(j) }
    end
  end
end
