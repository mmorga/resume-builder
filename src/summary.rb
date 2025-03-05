# frozen_string_literal: true

require "data_block"
require "yaml_order"

class Summary < DataBlock
  attr_reader :title, :content

  extend YamlOrder

  output_yaml_order :title, :content

  def title=(str)
    @title = default_string(str, "Summary")
  end

  def content=(con)
    @content = default_array(con)
  end
end
