# frozen_string_literal: true

require "data_block"
require "degree"
require "yaml_order"

class Education < DataBlock
  attr_reader :title, :degrees

  extend YamlOrder

  output_yaml_order :title, :degrees

  def title=(str)
    @title = default_string(str, "Education")
  end

  def degrees=(deg)
    @degrees = default_array(deg).map { |d| Degree.from_hash(d) }
  end
end
