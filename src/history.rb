# frozen_string_literal: true

require "data_block"
require "job"
require "yaml_order"

class History < DataBlock
  attr_reader :title, :jobs

  extend YamlOrder

  output_yaml_order :title, :jobs

  def title=(str)
    @title = default_string(str, "Experience")
  end

  def jobs=(job_list)
    @jobs = default_array(job_list).map { |j| Job.from_hash(j) }
  end
end
