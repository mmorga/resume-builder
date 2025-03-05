# frozen_string_literal: true

require "data_block"
require "yaml_order"

class Job < DataBlock
  attr_accessor :title, :company, :location, :dates
  attr_reader :content

  extend YamlOrder

  output_yaml_order :title, :company, :location, :dates, :content

  def content=(con)
    @content = default_array(con)
  end
end
